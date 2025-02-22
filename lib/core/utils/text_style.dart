import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyFontStyle {
  static const String sfProBold = "sfProBold";
  static const String sfProRegular = "sfProRegular";
  static const String sfProMedium = "sfProMedium";
  static const String sfProSemiBold = "sfProSemiBold";
  static const double _defaultFontSize = 13;

  static TextStyle bold(
      {double fontsize = _defaultFontSize,
      Color color = Colors.white,
      bool enabledUnderline = false,
      bool enabledLineThrough = false,
      double letterSpacing = 0.5,
      double height = 1.3,
      List<ui.Shadow>? shadows}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      shadows: shadows,
      color: color,
      height: height,
      fontFamily: sfProBold,
      fontSize: fontsize,
      decoration: TextDecoration.combine([
        enabledUnderline ? TextDecoration.underline : TextDecoration.none,
        enabledLineThrough ? TextDecoration.lineThrough : TextDecoration.none
      ]),
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle regular(
      {double fontsize = _defaultFontSize,
      Color color = Colors.white,
      bool enabledUnderline = false,
      bool enabledLineThrough = false,
      double height = 1.3,
      List<ui.Shadow>? shadows}) {
    return TextStyle(
      shadows: shadows,
      fontFamily: sfProRegular,
      color: color,
      fontSize: fontsize,
      height: height,
      letterSpacing: 0.5,
      decoration: TextDecoration.combine([
        enabledUnderline ? TextDecoration.underline : TextDecoration.none,
        enabledLineThrough ? TextDecoration.lineThrough : TextDecoration.none
      ]),
    );
  }

  static TextStyle medium(
      {double fontsize = _defaultFontSize,
      Color color = Colors.white,
      bool enabledUnderline = false,
      bool enabledLineThrough = false,
      double height = 1.3,
      List<ui.Shadow>? shadows}) {
    return TextStyle(
      shadows: shadows,
      fontFamily: sfProMedium,
      color: color,
      fontSize: fontsize,
      height: height,
      letterSpacing: 0.5,
      decoration: TextDecoration.combine([
        enabledUnderline ? TextDecoration.underline : TextDecoration.none,
        enabledLineThrough ? TextDecoration.lineThrough : TextDecoration.none
      ]),
    );
  }

  static TextStyle semiBold(
      {double fontsize = _defaultFontSize,
      Color color = Colors.white,
      bool enabledUnderline = false,
      bool enabledLineThrough = false,
      double height = 1.3,
      List<ui.Shadow>? shadows}) {
    return TextStyle(
      shadows: shadows,
      fontFamily: sfProSemiBold,
      color: color,
      fontSize: fontsize,
      height: height,
      letterSpacing: 0.5,
      decoration: TextDecoration.combine([
        enabledUnderline ? TextDecoration.underline : TextDecoration.none,
        enabledLineThrough ? TextDecoration.lineThrough : TextDecoration.none
      ]),
    );
  }
}
