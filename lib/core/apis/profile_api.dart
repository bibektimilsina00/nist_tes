import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/core/model/user_model.dart';
import 'package:nist_tes/core/services/service_locator.dart';
import 'package:nist_tes/core/utils/error_utils.dart';
import 'package:nist_tes/core/utils/logger_utils.dart';

import '../../app/routes/api_routes.dart';

class ProfileApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;

  ProfileApi();

  Future<UserModel> getMyProfile() async {
    try {
      if (!await _connectivityService.isConnected()) {
        final cachedUserProfile = await _cacheService.getUserProfile();
        if (cachedUserProfile != null) {
          logger.i('Fetching user profile from cache');
          return UserModel.fromJson(jsonDecode(cachedUserProfile));
        } else {
          throw const NoInternetException();
        }
      }

      logger.i('Fetching user profile from API');
      final response = await _apiClient.get(ApiRoutes.myProfile);

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final userModel = UserModel.fromJson(response.data);

      // Cache the user profile
      logger.i('Caching user profile data');
      await _cacheService.storeUserProfile(jsonEncode(userModel.toJson()));

      return userModel;
    } on DioException catch (e) {
      logger.e('DioException while fetching user profile: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate known exceptions
    } catch (e) {
      logger.e('Unexpected error while fetching user profile: $e');
      throw ServerException('Failed to fetch user profile: ${e.toString()}');
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Updating user profile');
      final response = await _apiClient.put(
        ApiRoutes.myProfile,
        data: user.toJson(),
      );

      if (response.statusCode != 200) {
        throw const ServerException('Failed to update profile');
      }

      // Update cache with new profile data
      logger.i('Updating cached user profile data');
      await _cacheService.storeUserProfile(jsonEncode(user.toJson()));
    } on DioException catch (e) {
      logger.e('DioException while updating user profile: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while updating user profile: $e');
      throw ServerException('Failed to update user profile: ${e.toString()}');
    }
  }

  Future<void> uploadProfilePicture(String filePath) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Uploading profile picture');
      final formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiClient.post(
        ApiRoutes.uploadProfilePicture,
        data: formData,
      );

      if (response.statusCode != 200) {
        throw const ServerException('Failed to upload profile picture');
      }

      // Optionally update cached profile with new picture URL
      await getMyProfile(); // Refresh profile data
    } on DioException catch (e) {
      logger.e('DioException while uploading profile picture: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while uploading profile picture: $e');
      throw ServerException(
          'Failed to upload profile picture: ${e.toString()}');
    }
  }
}
