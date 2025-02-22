import 'package:email_validator/email_validator.dart';

import 'constants.dart';


class FormValidator {
  final int maxLength = 15;

  static String? validateEmail(String? value) {
    if (value?.trim() == null || value!.trim().isEmpty) {
      return "Please enter email.";
    }
    if (!EmailValidator.validate(value.trim())) {
      return "Please enter a valid email.";
    }
    return null; // Return null if the input is valid
  }

  static String? validateEmailOrEmpty(String? value) {
    if (value?.trim() == null || value!.trim().isEmpty) {
      return null;
    }
    if (!EmailValidator.validate(value.trim())) {
      return "Please enter email.";
    }
    return null; // Return null if the input is valid
  }



  // static String? validatePassword(String? value) {
  //   if (value!.trim().isEmpty) {
  //     return TextConst.pleaseEnterPassword;
  //   } else if (value.trim().length < 8) {
  //     return TextConst.pleaseEnterValidPassword;
  //   }
  //   return null; // Return null if the input is valid
  // }
  // static String? validateConfirmPassword(
  //     String? value, String passwordValue) {
  //   if (value!.trim().isEmpty) {
  //     return TextConst.pleaseEnterConfirmPassword;
  //   } else if (value.trim() != passwordValue.trim()) {
  //     return TextConst.passwordsDoNotMatch;
  //   }
  //   return null;
  // }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter name.";
    } else if (value.trim().length < 2) {
      return "Name must be at least 2 characters.";
    } else if (value.trim().length > 50) {
      return "Name must not exceed 50 characters.";
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter OTP.";
    } else if (value.trim().length < 6) {
      return "Please enter a valid 6-digit OTP.";
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');

    if (value!.trim().isEmpty) {
      return "Please enter first name.";
    } else if (value.trim().length < 2) {
      return "First name must be at least 2 characters long.";
    } else if (!nameRegExp.hasMatch(value.trim())) {
      return "First name should not contain special characters or numbers.";
    } else if (value.trim().length > 50) {
      return "First name must not exceed 50 characters.";
    }
    return null;
  }

  static String? validateLastName(String? value) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');

    if (value == null || value.trim().isEmpty) {
      return "Please enter last name.";
    } else if (value.trim().length < 2) {
      return "Last name must be at least 2 characters long.";
    } else if (!nameRegExp.hasMatch(value.trim())) {
      return "Last name should not contain special characters or numbers.";
    } else if (value.trim().length > 50) {
      return "Last name must not exceed 50 characters.";
    }
    return null;
  }

  static String? validateNumber(String? value) {
    final phoneNumberPattern = RegExp(r'^\d{10}$');

    if (value == null || value.trim().isEmpty) {
      return Constants.pleaseEnterMobileNumber;
    }

    String removeSource = value
        .trim()
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp(r'^\+91'), '');

    if (!phoneNumberPattern.hasMatch(removeSource)) {
      return Constants.pleaseEnterValidMobileNumber;
    }

    return null;
  }

  static String? validateAddressType(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter address type.";
    } else if (value.trim().length < 2) {
      return "Please enter address type length must be 2 characters.";
    }
    return null;
  }

  static String? validateCoupon(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter coupon code.";
    } else if (value.trim().length < 10) {
      return "Please enter a valid coupon code.";
    }
    return null;
  }

  static String? validateRewardPoint(
      String? value, String pointsToConvertForUser) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter reward points.';
    } else if (int.tryParse(value.trim()) == null) {
      return 'Invalid reward points. Please enter a valid number.';
    }

    int rewardPoints = int.parse(value.trim());
    int dividePoint = int.parse(pointsToConvertForUser);

    if (rewardPoints <= 0) {
      return 'Reward points must be greater than 0.';
    } else if (rewardPoints % dividePoint != 0) {
      return 'Reward points must be divisible by $dividePoint.';
    }

    return null;
  }
}
