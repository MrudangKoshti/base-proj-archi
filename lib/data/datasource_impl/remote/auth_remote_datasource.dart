import 'dart:convert';


import 'package:http/src/response.dart';

import '../../../core/error/exceptions.dart' as exceptions;
import '../../../core/utils/constants.dart';
import '../../../core/utils/utility.dart';
import '../../datasource/remote/auth_remote_datasource.dart';
import '../../http_helper/http_helper.dart';
import '../../model/user_model.dart';
import '../http/api_endpoints.dart';



class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HTTPHelper httpHelper;

  AuthRemoteDataSourceImpl({
    required this.httpHelper,
  });
  @override
  Future<bool> sendOtp(
      {required String mobileNumber, required String appSignature}) async {
    // Preparing Query Parameters
    final Map<String, dynamic> variables = <String, dynamic>{
      "mobileNumber": mobileNumber,
      if (appSignature != "") "app_signature": appSignature
    };

    // Firing Query
    final Response result =
        await httpHelper.postCall(variables: variables, url: Api.sendOtp);

    final Map<String, dynamic> responseData =
        json.decode(result.body) as Map<String, dynamic>;

    if (responseData["success"] != true) {
      throw exceptions.ServerException(
        message: responseData["message"] != null
            ? responseData["message"] as String
            : Constants.errorMessage,
        exception: "Internal server error...",
      );
    } else {
      return true;
    }
  }

  @override
  Future<User?> verifyOtp(
      {required String mobileNumber, required int otp}) async {
    // Preparing Query Parameters
    final Map<String, dynamic> variables = <String, dynamic>{
      "mobileNumber": mobileNumber,
      "otp": otp
    };

    // Firing Query
    final Response result =
        await httpHelper.postCall(variables: variables, url: Api.verifyOtp);

    final Map<String, dynamic> responseData =
        json.decode(result.body) as Map<String, dynamic>;

    if (responseData["success"] != true) {
      throw exceptions.ServerException(
        message: responseData["message"] != null
            ? responseData["message"] as String
            : Constants.errorMessage,
        exception: "Internal server error...",
      );
    } else {
      if (responseData["data"]["user"] != null) {
        SharedPrefUtility.setToken(responseData['data']['token']);
        return User.fromJson(responseData["data"]["user"]);
      } else {
        
        return null;
      }
    }
  }
}
