import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> sendOtp({
    required String mobileNumber,
    required String appSignature,
  });

  Future<Either<Failure, User?>> verifyOtp({
    required String mobileNumber,
    required int otp,
  });
}
