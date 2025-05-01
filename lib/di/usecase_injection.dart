import '../domain/usecase/auth/send_otp.dart';
import '../domain/usecase/auth/verify_otp.dart';
import 'locator.dart';

void initUsecase() {
  locator
    ..registerFactory(() => SendOtp(locator()))
    ..registerFactory(() => VerifyOtp(authRepository: locator()));
}
