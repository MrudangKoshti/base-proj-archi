import '../core/platform/device_info.dart';

import '../core/platform/network_info.dart';
import 'locator.dart';

void initPlatformServices() {
  locator
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()))
    ..registerLazySingleton<DeviceInfo>(
      () => DeviceInfoImpl(packageInfo: locator()),
    );
}
