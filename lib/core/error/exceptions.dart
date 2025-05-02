import '../utils/constants.dart';

class ServerException implements Exception {
  final String message;
  final int code;
  final String exception;

  const ServerException({
    this.message = "Something unexpected happened!",
    this.code = -1,
    this.exception = "",
  });
}

class AuthException implements Exception {
  final String message;
  final int code;

  const AuthException({
    this.message = ExceptionConst.somethingUnexpectedHappened,
    this.code = -1,
  });
}

class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = ExceptionConst.somethingUnexpectedHappened,
  });
}

class DeviceException implements Exception {
  final String message;

  const DeviceException({
    this.message = ExceptionConst.somethingUnexpectedHappened,
  });
}

// Some common exceptions
const ServerException somethingWentWrong = ServerException(
  message: ExceptionConst.somethingWentWrong,
  exception: ExceptionConst.internalServerError,
);
