import 'package:shared_preferences/shared_preferences.dart';
import '../../di/locator.dart';
import 'constants.dart';

class SharedPrefUtility {
  SharedPrefUtility();

  static void setFirstTime() {
    locator
        .get<SharedPreferences>()
        .setBool(SharedPrefConstants.isFirstTime, false);
  }

  static String getToken() =>
      locator
          .get<SharedPreferences>()
          .getString(SharedPrefConstants.authToken) ??
      "";

  static void setToken(String token) {
    locator
        .get<SharedPreferences>()
        .setString(SharedPrefConstants.authToken, token);
  }

  static bool isFirstTime() =>
      locator
          .get<SharedPreferences>()
          .getBool(SharedPrefConstants.isFirstTime) ??
      true;

  static String getPopupViewTime() =>
      locator
          .get<SharedPreferences>()
          .getString(SharedPrefConstants.popupViewTime) ??
      "";

  static void setPopupViewTime(String time) {
    locator
        .get<SharedPreferences>()
        .setString(SharedPrefConstants.popupViewTime, time);
  }

  static void setAppOpenCount(int count) {
    locator
        .get<SharedPreferences>()
        .setInt(SharedPrefConstants.appOpenCount, count);
  }

  static int getAppOpenCount() {
    return locator
            .get<SharedPreferences>()
            .getInt(SharedPrefConstants.appOpenCount) ??
        0;
  }

// static ThemeMode getThemeMode() {
//   final int? themeModeIndex =
//       locator.get<SharedPreferences>().getInt(SharedPrefConstants.themeMode);
//   return themeModeIndex != null
//       ? ThemeMode.values[themeModeIndex]
//       : ThemeMode.system;
// }

// static void setThemeMode(ThemeMode themeMode) {
//   locator
//       .get<SharedPreferences>()
//       .setInt(SharedPrefConstants.themeMode, themeMode.index);
// }
}
