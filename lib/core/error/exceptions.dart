



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
    this.message = ExcaptionConst.somethingUnexpectedHappened,
    this.code = -1,
  });
}

class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = ExcaptionConst.somethingUnexpectedHappened,
  });
}

class DeviceException implements Exception {
  final String message;

  const DeviceException({
    this.message = ExcaptionConst.somethingUnexpectedHappened,
  });
}

// Some common exceptions
const ServerException somethingWentWrong = ServerException(
  message: ExcaptionConst.somethingWentWrong,
  exception: ExcaptionConst.internalServerError,
);
