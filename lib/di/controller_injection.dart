
import 'package:get/get.dart';


import '../presentation/controllers/auth_controller.dart';
import 'locator.dart';

void initControllers() {
  final authController = Get.put(
      AuthController(
          httpHelper: locator(),
          sendOtpUseCase: locator(),
          verifyOtpUseCase: locator()),
      permanent: true);
 

  locator
    ..registerLazySingleton(() => authController);
   
}
