import 'package:dio/dio.dart';

import '../../app/routes/api_routes.dart';
import '../services/service_locator.dart';
import '../utils/error_utils.dart';
import '../utils/logger_utils.dart';

class AuthenticationAPI {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;

  AuthenticationAPI();

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Changing password');
      final response = await _apiClient.post(
        ApiRoutes.changePassword,
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw const ServerException('Failed to change password');
      }
    } on DioException catch (e) {
      logger.e('DioException while changing password: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while changing password: $e');
      throw const ServerException('Failed to change password');
    }
  }

  Future<void> sendOtp({
    required String phone,
    String countryCode = '+977',
  }) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Sending OTP to $countryCode$phone');
      await _apiClient.post(
        ApiRoutes.sendOtp,
        data: {
          'phone_number': phone,
          'country_code': countryCode,
        },
      );
    } on DioException catch (e) {
      logger.e('DioException while sending OTP: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while sending OTP: $e');
      throw const ServerException('Failed to send OTP');
    }
  }

  Future<String> userLogin({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('User login attempt for $userEmail');
      final response = await _apiClient.post(
        ApiRoutes.login,
        data: {
          "email": userEmail,
          "password": userPassword,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['token'];
      } else {
        throw const ServerException('Invalid login response');
      }
    } on DioException catch (e) {
      logger.e('DioException during user login: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error during user login: $e');
      throw const ServerException('Failed to login');
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Verifying OTP for $phone');
      await _apiClient.post(
        ApiRoutes.verifyOtp,
        data: {
          'phone_number': phone,
          'otp': int.parse(otp),
        },
      );
    } on DioException catch (e) {
      logger.e('DioException while verifying OTP: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while verifying OTP: $e');
      throw const ServerException('Failed to verify OTP');
    }
  }
}
