import "dart:io";

import "package:package_info_plus/package_info_plus.dart";

abstract class DeviceInfo {
  // Returns Android or iOS
  String getPlatform();

  // Returns App Version Number
  String getAppVersion();

  // Returns App Build Number
  String getAppBuildNumber();


}

class DeviceInfoImpl extends DeviceInfo {
  final PackageInfo packageInfo;


  DeviceInfoImpl({required this.packageInfo});

  @override
  String getPlatform() => Platform.isIOS ? "iOS" : "Android";

  @override
  String getAppVersion() => packageInfo.version;

  @override
  String getAppBuildNumber() => packageInfo.buildNumber;

 
}
