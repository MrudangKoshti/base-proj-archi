import "package:flutter/material.dart";
import "../core/routing/routes_name.dart";

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String previousRoute = AppRoutes.defaultRoute;
  String currentRoute = AppRoutes.defaultRoute;

  Future<dynamic> pushNamed(
    String routeName, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) =>
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacement(
    String routeName, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) =>
      navigatorKey.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic> removeAllAndPush(
    String routeName, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  Future<dynamic> removeUntilAndPush(
    String routeName,
    String untilRoute, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => route.settings.name == untilRoute,
        arguments: arguments,
      );

  Future<dynamic> popUntil(
    String routeName, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) async {
    navigatorKey.currentState!.popUntil((Route<dynamic> currentRouteName) {
      final bool result = currentRouteName.settings.name == routeName;
      if (result) {
        final String tempRoute = currentRoute;
        currentRoute = routeName;
        previousRoute = tempRoute;
      }
      return result;
    });
  }

  void pop<T>({T? result, bool resetColor = true}) {
    final String tempRoute = currentRoute;
    currentRoute = previousRoute;
    previousRoute = tempRoute;
    return navigatorKey.currentState!.pop(result);
  }

  /// Setters
  ///
  ///

  /// Set the current route and previous route
  /// based on the navigation
  set currentRouteName(String routeName) {
    previousRoute = currentRoute;
    currentRoute = routeName;
  }

  /// Getters
  ///
  ///

  /// Returns current route name
  String get currentRouteName => currentRoute;
}
