import 'package:base_project/di/platform_services.dart';
import 'package:base_project/di/repositories_injection.dart';
import 'package:base_project/di/service_injection.dart';
import 'package:base_project/di/usecase_injection.dart';
import 'package:base_project/di/util_injection.dart';
import 'package:get_it/get_it.dart';

import 'controller_injection.dart';
import 'datasource_injection.dart';
import 'external_dependencies.dart';

final GetIt locator = GetIt.instance;

Future<void> init() async {
  await initExternalDependencies();

  //services
  initService();

  // util
  initUtils();

  //platformServices
  initPlatformServices();

  // Repositories
  initRepositories();

  // Usecases
  initUsecase();

  // Datasources
  initDataSource();

  //controllers
  initControllers();
}
