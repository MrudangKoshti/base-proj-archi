import 'package:base_project/data/env.dart';
import 'package:dio/dio.dart';

// HTTP Method enum
enum HttpMethod { get, post, put, delete }

// Generic API Response class
class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? errorMessage;
  final int? statusCode;

  ApiResponse({
    this.data,
    this.success = true,
    this.errorMessage,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {int? statusCode}) =>
      ApiResponse(data: data, success: true, statusCode: statusCode);

  factory ApiResponse.error(String message, {int? statusCode}) => ApiResponse(
    success: false,
    errorMessage: message,
    statusCode: statusCode,
  );
}

// HTTP Client Interface
abstract class HttpClientInterface {
  Future<ApiResponse<T>> request<T>(
    String path, {
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    T Function(Map<String, dynamic>)? fromJson,
  });

  void setAuthToken(String token);
  void clearAuthToken();
  void setHeaders(Map<String, String> headers);
  void setOnUnauthorizedCallback(void Function() callback);
}

// Custom HTTP Client
class HttpClient implements HttpClientInterface {
  final Dio _dio;
  String? _authToken;
  Map<String, String> _customHeaders = {};
  void Function()? _onUnauthorized;

  HttpClient(this._dio) {
    _dio.options.baseUrl = Env.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Merge custom headers
          options.headers.addAll(_customHeaders);
          // Add Authorization header if token is set
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401 && _onUnauthorized != null) {
            // Invoke the unauthorized callback
            _onUnauthorized!();
            // Prevent infinite loops by not calling handler.next for 401
            return handler.resolve(
              Response(
                requestOptions: e.requestOptions,
                statusCode: 401,
                statusMessage: 'Unauthorized',
                data: {'message': 'Token expired or invalid'},
              ),
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  void setAuthToken(String token) {
    _authToken = token;
  }

  @override
  void clearAuthToken() {
    _authToken = null;
  }

  @override
  void setHeaders(Map<String, String> headers) {
    _customHeaders = {...headers};
  }

  @override
  void setOnUnauthorizedCallback(void Function() callback) {
    _onUnauthorized = callback;
  }

  @override
  Future<ApiResponse<T>> request<T>(
    String path, {
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      Response response;
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(path, queryParameters: queryParameters);
          break;
        case HttpMethod.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.put:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.delete:
          response = await _dio.delete(
            path,
            queryParameters: queryParameters,
            data: data,
          );
          break;
      }
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    }
  }

  // Parse response
  ApiResponse<T> _parseResponse<T>(
    Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    final statusCode = response.statusCode ?? 0;

    if (statusCode >= 200 && statusCode < 300) {
      if (T == String || T == int || T == double || T == bool) {
        return ApiResponse.success(response.data as T, statusCode: statusCode);
      }

      if (fromJson != null) {
        if (response.data is List) {
          final List<dynamic> dataList = response.data;
          final parsedList = dataList.map((item) => fromJson(item)).toList();
          return ApiResponse.success(parsedList as T, statusCode: statusCode);
        } else if (response.data is Map<String, dynamic>) {
          final parsedData = fromJson(response.data);
          return ApiResponse.success(parsedData, statusCode: statusCode);
        }
      }

      return ApiResponse.success(response.data as T, statusCode: statusCode);
    }

    return ApiResponse.error(
      response.statusMessage ?? 'Unknown error',
      statusCode: statusCode,
    );
  }

  // Handle errors
  ApiResponse<T> _handleError<T>(DioException e) {
    String errorMessage;
    int? statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        statusCode = e.response?.statusCode;
        errorMessage = e.response?.statusMessage ?? 'Invalid response';
        try {
          if (e.response?.data is Map<String, dynamic>) {
            final errorData = e.response!.data as Map<String, dynamic>;
            errorMessage = errorData['message'] ?? errorMessage;
          }
        } catch (_) {}
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      default:
        errorMessage = e.message ?? 'Unknown error';
    }

    return ApiResponse.error(errorMessage, statusCode: statusCode);
  }
}
