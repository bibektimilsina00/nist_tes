import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app/api_client/api_client.dart';
import '../../app/routes/api_routes.dart';
import '../../core/utils/error_utils.dart';
import '../model/user_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

class ProfileApi {
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final CacheService _cacheService;

  ProfileApi(this._apiClient, this._connectivityService, this._cacheService);

  Future<UserModel> getMyProfile() async {
    try {
      if (await _connectivityService.isConnected()) {
        final response = await performGetRequest(ApiRoutes.myProfile);
        final userModel = UserModel.fromJson(response);
        await _cacheService.storeUserProfile(jsonEncode(userModel.toJson()));

        return userModel;
      } else {
        final cachedUserProfile = await _cacheService.getUserProfile();
        if (cachedUserProfile != null) {
          return UserModel.fromJson(jsonDecode(cachedUserProfile));
        } else {
          throw Exception(
              "No internet connection and no cached data available");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> performGetRequest(
    String endpoint,
  ) async {
    try {
      final response = await _apiClient.get(
        endpoint,
      );
      return response.data;
    } on DioException catch (e) {
      await handleDioException(e);
      rethrow;
    }
  }
}
