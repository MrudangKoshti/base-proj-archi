import 'dart:convert';

import 'package:base_project/core/error/exceptions.dart' as exceptions;
import 'package:base_project/core/utils/constants.dart';
import 'package:base_project/core/utils/utility.dart';
import 'package:base_project/data/datasource/remote/auth_remote_datasource.dart';
import 'package:base_project/data/http_helper/http_helper.dart';
import 'package:base_project/data/model/user_model.dart';
import 'package:base_project/data/datasource_impl/http/api_endpoints.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpClientInterface httpClient;
  AuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<bool> sendOtp({
    required String mobileNumber,
    required String appSignature,
  }) async {
    // Preparing Query Parameters
    // final Map<String, dynamic> variables = <String, dynamic>{
    //   "mobileNumber": mobileNumber,
    //   if (appSignature != "") "app_signature": appSignature,
    // };

    // Firing Query
    // final Response result = await httpClient.request(
    //   variables: variables,
    //   url: Api.sendOtp,
    // );

    // final Map<String, dynamic> responseData =
    //     json.decode(result.body) as Map<String, dynamic>;

    // if (responseData["success"] != true) {
    //   throw exceptions.ServerException(
    //     message:
    //         responseData["message"] != null
    //             ? responseData["message"] as String
    //             : Constants.errorMessage,
    //     exception: "Internal server error...",
    //   );
    // } else {
    //   return true;
    // }
    return true;
  }

  @override
  Future<User?> verifyOtp({
    required String mobileNumber,
    required int otp,
  }) async {
    // Preparing Query Parameters
    final Map<String, dynamic> variables = <String, dynamic>{
      "mobileNumber": mobileNumber,
      "otp": otp,
    };

    // Firing Query
    final result = await httpClient.request<User?>(
      Api.verifyOtp,
      method: HttpMethod.post,
      data: variables,
      fromJson: User.fromJson,
    );

    // final Map<String, dynamic> responseData =
    //     json.decode(result.body) as Map<String, dynamic>;

    // if (responseData["success"] != true) {
    //   throw exceptions.ServerException(
    //     message:
    //         responseData["message"] != null
    //             ? responseData["message"] as String
    //             : Constants.errorMessage,
    //     exception: "Internal server error...",
    //   );
    // } else {
    //   if (responseData["data"]["user"] != null) {
    //     SharedPrefUtility.setToken(responseData['data']['token']);
    //     return User.fromJson(responseData["data"]["user"]);
    //   } else {
    //     return null;
    //   }
    // }

    return null;
  }
}

