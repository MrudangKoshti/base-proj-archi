import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../http_helper/repository_helper.dart';
import '../model/user_model.dart';



class AuthRepositoriesImpl extends AuthRepository {
  final RepositoryHelper<dynamic> repositoryHelper;
  final AuthRemoteDataSource remoteDatasource;

  AuthRepositoriesImpl(
      {required this.repositoryHelper, required this.remoteDatasource});
  @override
  Future<Either<Failure, bool>> sendOtp(
      {required String mobileNumber, required String appSignature}) async {
    final Either<Failure, dynamic> failureOrSuccess =
        await repositoryHelper.callAPI(() async {
      final bool result = await remoteDatasource.sendOtp(
          appSignature: appSignature, mobileNumber: mobileNumber);

      return result;
    });

    return failureOrSuccess.fold(
      (Failure l) => Left<Failure, bool>(l),
      (dynamic r) => Right<Failure, bool>(r as bool),
    );
  }

  @override
  Future<Either<Failure, User?>> verifyOtp(
      {required String mobileNumber, required int otp}) async {
    Either<Failure, dynamic> failureOrSuccess =
        await repositoryHelper.callAPI(() async {
      final user = await remoteDatasource.verifyOtp(
          mobileNumber: mobileNumber, otp: otp);
      return user;
    });

    return failureOrSuccess.fold((Failure l) => Left<Failure, User?>(l),
        (dynamic r) => Right<Failure, User?>(r as User?));
  }
}
