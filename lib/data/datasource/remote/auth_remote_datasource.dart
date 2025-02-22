


import '../../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> sendOtp(
      {required String mobileNumber, required String appSignature});

  Future<User?> verifyOtp({required String mobileNumber, required int otp});
}
