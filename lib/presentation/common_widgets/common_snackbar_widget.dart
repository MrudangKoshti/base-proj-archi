
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/text_style.dart';

class CommonSnackBar {
  static void showError({BuildContext? context, required String message}) {
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: MyFontStyle.bold(color: Colors.white),
        ),
        barBlur: 15,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        backgroundColor: Colors.red.shade600.withOpacity(0.7),
       
        margin: const EdgeInsets.all(15));
  }

  static void showSimpleMessage(
      {required BuildContext context, required String message}) {
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        barBlur: 15,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        backgroundColor: AppColors.lightGreen,
       
        margin: const EdgeInsets.all(15));
  }
}
