

import '../services/navigation_services.dart';
import 'locator.dart';

void initService() {
  locator
    ..registerLazySingleton(() => NavigationService());
   
   
}
