import 'dart:io';
import 'package:base_project/services/navigation_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import 'core/routing/routing.dart';
import 'core/utils/theme_service.dart';
import 'di/locator.dart' as di;


Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id;
  }
  return null;
}

Future<String?> _getDeviceOSVersion() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.systemVersion;
  } else if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.release;
  }
  return null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
 

  await di.init();
  FlutterNativeSplash.remove();


  runApp(
    // DevicePreview(
    // builder: (context) =>
    const MyApp(),
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Clean Architecture',
        theme: ThemeService.lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: ThemeService.darkTheme,
        navigatorKey: di.locator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings routeSettings) => generateRoute(
            routeSettings,
           
            navigationService: di.locator<NavigationService>()),
        builder: (BuildContext ctx, Widget? widget) =>
        
           MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: widget!,
          ),
        
      );
    });
  }
}
