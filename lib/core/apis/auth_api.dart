import 'package:dio/dio.dart';

import '../../app/api_client/api_client.dart';
import '../../app/routes/api_routes.dart';
import '../utils/error_utils.dart';

class AuthenticationAPI {
  final ApiClient _apiClient;

  const AuthenticationAPI(this._apiClient);

  Future<dynamic> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      Response response = await _apiClient.post(
        ApiRoutes.baseUrl + ApiRoutes.changePassword,
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to change password');
      }
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  Future<dynamic> sendOtp(
      {required String phone, String countryCode = '+977'}) async {
    return _performPostRequest(ApiRoutes.sendOtp, {
      'phone_number': phone,
      'country_code': countryCode,
    });
  }

  Future<String> userLogin(
      {required String userEmail, required String userPassword}) async {
    try {
      Response response =
          await _apiClient.post(ApiRoutes.baseUrl + ApiRoutes.login, data: {
        "email": userEmail,
        "password": userPassword,
      });

      return response.data['token'];
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  Future<dynamic> verifyOtp(
      {required String phone, required String otp}) async {
    return _performPostRequest(ApiRoutes.verifyOtp, {
      'phone_number': phone,
      'otp': int.parse(otp),
    });
  }

  void _handleError(DioException e) {
    String errorMessage = "An error occurred";
    if (e.response != null &&
        e.response!.data is Map &&
        e.response!.data.containsKey('detail')) {
      errorMessage = e.response!.data['detail'];
    }
    throw Exception(errorMessage);
  }

  Future<dynamic> _performPostRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }
}
