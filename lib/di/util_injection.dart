import '../data/http_helper/http_helper.dart';
import 'locator.dart';

void initUtils() {
  locator.registerLazySingleton<HTTPHelper>(
    () => HTTPHelperImpl(client: locator()),
  );
}
