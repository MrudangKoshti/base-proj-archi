import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/http_helper/http_helper.dart';
import 'locator.dart';

Future<void> initExternalDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  locator
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton(() => packageInfo)
    ..registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker(),
    )
    ..registerLazySingleton<Dio>(() => Dio())
    ..registerLazySingleton<HttpClientInterface>(() => HttpClient(locator()));
}


