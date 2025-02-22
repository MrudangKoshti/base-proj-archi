import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../../data/model/user_model.dart';
import '../../repositories/auth_repository.dart';



class VerifyOtp extends UseCase<User?, Params> {
  final AuthRepository authRepository;

  VerifyOtp({required this.authRepository});

  @override
  Future<Either<Failure, User?>> call(Params params) =>
      authRepository.verifyOtp(
          mobileNumber: params.authParams!.mobileNumber!,
          otp: params.authParams!.otp!);
}
