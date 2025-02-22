
import "package:base_project/core/routing/routes_name.dart";
import "package:flutter/material.dart";

import "package:page_transition/page_transition.dart";


getCupertinoSlideRoute(
  Widget child,
  RouteSettings settings, {
  bool isFromBottom = false,
}) =>
    PageTransition(
        child: child,
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        settings: RouteSettings(name: settings.name ?? AppRoutes.defaultRoute),
        reverseDuration: const Duration(milliseconds: 200));
