import 'dart:async'; // Import for using TimeoutException
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


import '../../core/platform/device_info.dart';
import '../../core/utils/utility.dart';
import '../../di/locator.dart';
import '../../presentation/common_widgets/common_snackbar_widget.dart';

abstract class HTTPHelper {
  Future<Response> getCall({required String url});

  Future<Response> postCall(
      {required Map<String, dynamic> variables, required String url});

  Future<Response> patchCall(
      {required Map<String, dynamic> variables, required String url});

  Future<Response> putCall(
      {required Map<String, dynamic> variables, required String url});

  Future<Response> deleteCall(
      {required String url, Map<String, dynamic>? variables});

  Future<Response> postCallWithTempToken(
      {required String url,
      required Map<String, dynamic> variables,
      required String tempToken});
}

class HTTPHelperImpl extends HTTPHelper {
  final Client client;
  final Duration timeoutDuration =
      const Duration(seconds: 30); // Set timeout duration

  HTTPHelperImpl({required this.client});

  @override
  Future<http.Response> getCall({required String url}) async {
     
        final String token = SharedPrefUtility.getToken();
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();

        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
         final http.Response response = await client.get(Uri.parse(url), headers: <String, String>{
          "Content-Type": "application/json",
          if (token != "") "Authorization": token,
          "deviceType": deviceType,
        
          "appVersion": appVersion
        });

        return response;
   
  }

  @override
  Future<http.Response> postCall(
      {required Map<String, dynamic>? variables, required String url}) async {
   
        final String token = SharedPrefUtility.getToken();
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();
        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
         final http.Response response = await client.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json",
            if (token != "") "Authorization": token,
           
            "deviceType": deviceType,
            "appVersion": appVersion
          },
          body: json.encode(variables),
        );

        return response;
   
  }

  @override
  Future<http.Response> patchCall(
      {required Map<String, dynamic> variables, required String url}) async {
    
        final String token = SharedPrefUtility.getToken();
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();
        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
         final http.Response response = await client.patch(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json",
            if (token != "") "Authorization": token,
            "deviceType": deviceType,
          
            "appVersion": appVersion
          },
          body: json.encode(variables),
        );
    return response;
  }

  @override
  Future<http.Response> putCall(
      {required Map<String, dynamic> variables, required String url}) async {
     
        final String token = SharedPrefUtility.getToken();
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();
        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
       final http.Response response = await client.put(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json",
            if (token != "") "Authorization": token,
            "deviceType": deviceType,
          
            "appVersion": appVersion
          },
          body: json.encode(variables),
        );

        return response;
    
  }

  @override
  Future<http.Response> deleteCall(
      {required String url, Map<String, dynamic>? variables}) async {
    
        final String token = SharedPrefUtility.getToken();
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();
        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
        final http.Response response = await client.delete(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json",
            if (token != "") "Authorization": token,
            "deviceType": deviceType,
          
            "appVersion": appVersion
          },
        );

        return response;
    
  }

  @override
  Future<http.Response> postCallWithTempToken(
      {required Map<String, dynamic>? variables,
      required String url,
      required String tempToken}) async {
  
        final String deviceType =
            locator.get<DeviceInfo>().getPlatform().toLowerCase();
        final String appVersion = locator.get<DeviceInfo>().getAppVersion();
      final http.Response response = await   client.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": tempToken,
          
            "deviceType": deviceType,
            "appVersion": appVersion
          },
          body: json.encode(variables),
        );

        return response;
    
  }



  void _unauthorised(Response response) {
    // Handle unauthorised requests
    // locator.get<AuthController>().logoutUser();
    CommonSnackBar.showError(message: "Session Expired Please Login Again");
    // throw const exceptions.AuthException(message: "Please login again");
  }
}
