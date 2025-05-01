import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/http_helper/http_helper.dart';
import '../../domain/usecase/auth/send_otp.dart';
import '../../domain/usecase/auth/verify_otp.dart';

class AuthController extends GetxController {
  final HttpClient httpClient;

  //UseCases
  final SendOtp sendOtpUseCase;
  final VerifyOtp verifyOtpUseCase;

  AuthController({
    required this.httpClient,
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
  });
}
