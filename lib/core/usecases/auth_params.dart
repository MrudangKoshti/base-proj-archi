import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  final String? mobileNumber;
  final String? appSignature;
  final int? otp;

  AuthParams({this.mobileNumber, this.appSignature, this.otp});

  @override
  // TODO: implement props
  List<Object?> get props => [mobileNumber, appSignature, otp];
}
