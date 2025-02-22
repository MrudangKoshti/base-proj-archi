import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomFadeRoute extends PageTransition {
  CustomFadeRoute({
    required Widget child,
    required String routeName,
    bool isFromBottom = false,
  }) : super(
          child: child,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 300),
          settings: RouteSettings(name: routeName),
          fullscreenDialog: false,
          curve: Curves.linearToEaseOut,
        );
}
