import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../repositories/auth_repository.dart';

class SendOtp extends UseCase<bool, Params> {
  final AuthRepository repository;

  SendOtp(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) => repository.sendOtp(
    mobileNumber: params.authParams!.mobileNumber!,
    appSignature: params.authParams!.appSignature!,
  );
}
