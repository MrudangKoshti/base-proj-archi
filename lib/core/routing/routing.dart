import 'package:base_project/core/routing/routes_name.dart';
import 'package:base_project/core/routing/routing_animation.dart';
import 'package:flutter/material.dart';

import '../../presentation/auth_screens/splash_screen.dart';
import '../../services/navigation_services.dart';

Route<dynamic> generateRoute(
  RouteSettings settings, {
  required NavigationService navigationService,
}) {
  // setting current route in NavigationService
  navigationService.currentRoute = settings.name ?? AppRoutes.defaultRoute;

  switch (settings.name) {
    case AppRoutes.defaultRoute:
      return getCupertinoSlideRoute(const SplashScreen(), settings);

    default:
      return getCupertinoSlideRoute(const SplashScreen(), settings);
  }
}
