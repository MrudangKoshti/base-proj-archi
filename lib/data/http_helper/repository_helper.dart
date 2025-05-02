import "dart:async";

import "package:dartz/dartz.dart";

import "../../core/error/exception_constants.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";
import "../../core/platform/network_info.dart";
import "../../core/utils/constants.dart";

abstract class RepositoryHelper<T> {
  //TODO: DOCUMENTATION
  Future<Either<Failure, T>> callAPI(FutureOr<T> Function() apiCall);
}

class RepositoryHelperImpl<T> extends RepositoryHelper<dynamic> {
  final NetworkInfo networkInfo;

  RepositoryHelperImpl(this.networkInfo);

  @override
  Future<Either<Failure, dynamic>> callAPI(
    FutureOr<dynamic> Function() apiCall,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        return Right<Failure, dynamic>(await apiCall());
      } else {
        throw deviceException;
      }
    } on ServerException catch (e) {
      return Left<Failure, dynamic>(
        ServerFailure(message: e.message, exception: e.exception, code: e.code),
      );
    } on AuthException catch (e) {
      return Left<Failure, dynamic>(
        AuthFailure(
          message: ExceptionConst.userSessionExpired,
          exception: e.message,
          code: e.code,
        ),
      );
    } on DeviceException catch (e) {
      return Left<Failure, dynamic>(
        DeviceFailure(
          message: ExceptionConst.noInternetConnection,
          exception: e.message,
        ),
      );
    } on CacheException catch (e) {
      return Left<Failure, dynamic>(
        CacheFailure(
          message: ExceptionConst.failedToAccessCache,
          exception: e.message,
        ),
      );
    }
  }
}
