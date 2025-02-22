import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class CommonFunctions {
// For Greeting Message //
  static String greetingMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }





  static String formatDate(DateTime dateTime) {
    return DateFormat('d MMM').format(dateTime.toLocal());
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String dateFormat(DateTime dateTime) {
    return DateFormat('d MMM \'at\' hh:mm a').format(dateTime.toLocal());
  }

  static String formatDateNotification(String inputDate) {
    DateTime dateTime;

    if (inputDate.isEmpty) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(inputDate).toLocal();
    }

    final now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} ${difference.inMinutes > 1 ? 'Mins' : 'Min'} ago";
    } else if (difference.inHours < 24 && now.day == dateTime.day) {
      return "Today";
    } else if (yesterday.year == dateTime.year &&
        yesterday.month == dateTime.month &&
        yesterday.day == dateTime.day) {
      return "Yesterday";
    } else {
      DateFormat dateFormat = DateFormat('d MMM, yyyy hh:mm a');
      return dateFormat.format(dateTime.toLocal());
    }
  }

  static DateTime convertdate(String inputDate) {
    DateTime dateTime;

    if (inputDate.isEmpty) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(inputDate);
    }

    return dateTime;
  }




  static String getFormattedTime(DateTime selectedDateTimeInUTC) {
    DateTime localTime = selectedDateTimeInUTC.toLocal();
    return DateFormat('h:mm a').format(localTime);
  }





  static String formatDateInDateAndTime(String inputDate) {
    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the date and time using the desired pattern
    DateFormat dateFormat = DateFormat('d MMM yyyy • hh:mm a');
    String formattedDate = dateFormat.format(dateTime.toLocal());

    return formattedDate;
  }



 
}
