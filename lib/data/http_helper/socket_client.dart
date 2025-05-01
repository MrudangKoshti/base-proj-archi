import 'dart:async';
import 'dart:convert';
import 'package:base_project/data/env.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Generic Socket Message class
class SocketMessage<T> {
  final T? data;
  final bool success;
  final String? errorMessage;
  final String? event;

  SocketMessage({
    this.data,
    this.success = true,
    this.errorMessage,
    this.event,
  });

  factory SocketMessage.success(T data, {String? event}) =>
      SocketMessage(data: data, success: true, event: event);

  factory SocketMessage.error(String message, {String? event}) =>
      SocketMessage(success: false, errorMessage: message, event: event);
}

// Subscriber class to hold callback and type information
class _SocketSubscriber<T> {
  final void Function(SocketMessage<T>) callback;
  final T Function(Map<String, dynamic>)? fromJson;
  final String? event;

  _SocketSubscriber({required this.callback, this.fromJson, this.event});
}

// Socket Client Interface
abstract class SocketClientInterface {
  void subscribe<T>({
    required void Function(SocketMessage<T>) onMessage,
    T Function(Map<String, dynamic>)? fromJson,
    String? event,
  });
  void unsubscribe<T>({
    required void Function(SocketMessage<T>) onMessage,
    String? event,
  });
  Future<void> send(String event, dynamic data);
  Future<void> connect();
  Future<void> disconnect();
  void setHeaders(Map<String, String> headers);
  void setAuthToken(String token);
  void clearAuthToken();
  bool get isConnected;
  Stream<List<ConnectivityResult>> get connectivityStream;
}

// Custom Socket Client
class SocketClient implements SocketClientInterface {
  IO.Socket? _socket;
  String? _authToken;
  Map<String, String> _customHeaders = {};
  final String _url;
  bool _isConnecting = false;
  bool _isConnected = false;
  final List<_SocketSubscriber> _subscribers = [];
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  SocketClient({String? url}) : _url = url ?? Env.websocketUrl {
    _initializeSocket();
    _startNetworkMonitoring();
  }

  @override
  bool get isConnected => _isConnected;

  @override
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  @override
  void setHeaders(Map<String, String> headers) {
    _customHeaders = {...headers};
    if (_socket != null) {
      _reconnect();
    }
  }

  @override
  void setAuthToken(String token) {
    _authToken = token;
    if (_socket != null) {
      _reconnect();
    }
  }

  @override
  void clearAuthToken() {
    _authToken = null;
    if (_socket != null) {
      _reconnect();
    }
  }

  @override
  void subscribe<T>({
    required void Function(SocketMessage<T>) onMessage,
    T Function(Map<String, dynamic>)? fromJson,
    String? event,
  }) {
    _subscribers.add(
      _SocketSubscriber<T>(
        callback: onMessage,
        fromJson: fromJson,
        event: event,
      ),
    );
    if (_socket == null && _subscribers.isNotEmpty && !_isConnecting) {
      connect();
    }
  }

  @override
  void unsubscribe<T>({
    required void Function(SocketMessage<T>) onMessage,
    String? event,
  }) {
    _subscribers.removeWhere(
      (s) => s.callback == onMessage && s.event == event,
    );
    if (_subscribers.isEmpty) {
      disconnect();
    }
  }

  @override
  Future<void> connect() async {
    if (_socket != null || _isConnecting) return;

    _isConnecting = true;
    try {
      final headers = {
        ..._customHeaders,
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

      _socket = IO.io(
        _url,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setReconnectionAttempts(99999)
            .setReconnectionDelay(10000)
            .disableAutoConnect()
            .enableReconnection()
            .setExtraHeaders(headers)
            .build(),
      );

      _socket!.connect();

      _socket!.onConnect((_) {
        _isConnected = true;
        _isConnecting = false;
        _broadcastMessage(SocketMessage.success(null, event: 'connect'));
      });

      _socket!.onDisconnect((_) {
        _isConnected = false;
        _broadcastMessage(
          SocketMessage.error('Disconnected', event: 'disconnect'),
        );
      });

      _socket!.onError((error) {
        _isConnected = false;
        _broadcastMessage(
          SocketMessage.error('Socket error: $error', event: 'error'),
        );
      });

      _socket!.onReconnect((_) {
        _isConnected = true;
        _broadcastMessage(SocketMessage.success(null, event: 'reconnect'));
      });

      _socket!.onReconnectAttempt((data) {
        _broadcastMessage(
          SocketMessage.success(data, event: 'reconnectAttempt'),
        );
      });

      _socket!.onReconnectFailed((data) {
        _broadcastMessage(
          SocketMessage.error('Reconnect failed', event: 'reconnectFailed'),
        );
      });

      _socket!.onPing((data) {
        _socket!.emit('pong', {'success': true});
        _broadcastMessage(SocketMessage.success(data, event: 'ping'));
      });

      _socket!.onPong((data) {
        _broadcastMessage(SocketMessage.success(data, event: 'pong'));
      });

      // Handle custom events dynamically
      _socket!.onAny((event, data) {
        _broadcastMessage(_parseMessage(data, event));
      });
    } catch (e) {
      _isConnecting = false;
      _broadcastMessage(
        SocketMessage.error('Connection error: $e', event: 'error'),
      );
    }
  }

  @override
  Future<void> disconnect() async {
    if (_socket != null) {
      _socket!.clearListeners();
      _socket!.disconnect();
      _socket = null;
    }
    _isConnected = false;
  }

  @override
  Future<void> send(String event, dynamic data) async {
    if (_socket == null) {
      await connect();
    }
    if (_socket != null && _isConnected) {
      _socket!.emit(event, data);
    }
  }

  void _initializeSocket() {
    // Delayed initialization similar to your code
    Future.delayed(const Duration(seconds: 2)).then((_) => connect());
  }

  void _startNetworkMonitoring() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        if (!_isConnected && _subscribers.isNotEmpty) {
          connect();
        }
      } else {
        _isConnected = false;
        _broadcastMessage(
          SocketMessage.error('Network unavailable', event: 'network'),
        );
      }
    });
  }

  SocketMessage<T> _parseMessage<T>(dynamic data, String event) {
    try {
      final subscribers =
          _subscribers
              .where((s) => s.event == null || s.event == event)
              .toList();
      if (subscribers.isEmpty) return SocketMessage.success(data, event: event);

      for (final subscriber in subscribers) {
        if (subscriber.fromJson != null) {
          if (data is String) {
            final jsonData = jsonDecode(data);
            if (jsonData is List) {
              final parsedList =
                  jsonData.map((item) => subscriber.fromJson!(item)).toList();
              return SocketMessage.success(parsedList as T, event: event);
            } else if (jsonData is Map<String, dynamic>) {
              final parsedData = subscriber.fromJson!(jsonData);
              return SocketMessage.success(parsedData as T, event: event);
            }
          } else if (data is Map<String, dynamic>) {
            final parsedData = subscriber.fromJson!(data);
            return SocketMessage.success(parsedData as T, event: event);
          }
        }
      }
      return SocketMessage.success(data as T, event: event);
    } catch (e) {
      return SocketMessage.error('Failed to parse message: $e', event: event);
    }
  }

  void _broadcastMessage(SocketMessage message) {
    for (final subscriber in _subscribers) {
      if (subscriber.event == null || subscriber.event == message.event) {
        subscriber.callback(message);
      }
    }
  }

  void _reconnect() {
    disconnect();
    if (_subscribers.isNotEmpty) {
      _initializeSocket();
    }
  }
}
