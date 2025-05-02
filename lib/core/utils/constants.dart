import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xff1D61E7);
  static Color lightGreen = const Color(0xff8CC63F);
  static Color white = const Color(0xffF4F4F4);
}

class Constants {
  static const String pleaseEnterMobileNumber = "Please enter mobile number.";
  static const String pleaseEnterValidMobileNumber =
      "Please enter a valid mobile number.";
  static const String errorMessage =
      "Something went wrong, Please try again later or contact admin";
}

class SharedPrefConstants {
  static String authToken = "token";
  static String isFirstTime = "isFirstTime";
  static String popupViewTime = "popupViewTime";
  static String appOpenCount = "appOpenCount";
}

class ExceptionConst {
  static const String noInternetConnection = "Device is Offline!";
  static const String somethingUnexpectedHappened =
      "Something unexpected happened!";
  static const String somethingWentWrong = "Something went wrong...";
  static const String internalServerError = "Internal server error...";
  static const String userSessionExpired = "User Session Expired!";
  static const String failedToAccessCache = "Failed to access cache!";
  static const String unexpectedError = "Unexpected Error...";
}
