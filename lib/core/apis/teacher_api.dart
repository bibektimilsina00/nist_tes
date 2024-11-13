import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/app/const/app_constant.dart';

import '../../app/api_client/api_client.dart';
import '../../app/routes/api_routes.dart';
import '../model/teacher_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../utils/error_utils.dart';

class TeacherApi {
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final CacheService _cacheService;

  TeacherApi(this._apiClient, this._connectivityService, this._cacheService);

  Future<List<TeacherModel>> getTeachers() async {
    try {
      if (await _connectivityService.isConnected()) {
        final response =
            await performGetRequest(ApiRoutes.teachers + AppConst.sectionId);
        final teacherList = (response)
            .map((teacher) => TeacherModel.fromJson(teacher))
            .toList();

        await _cacheService.storeTeacherProfile(jsonEncode(
            teacherList.map((teacher) => teacher.toJson()).toList()));

        return teacherList;
      } else {
        final cachedTeacherProfile = await _cacheService.getTeacherProfile();
        if (cachedTeacherProfile != null) {
          final teacherList = (jsonDecode(cachedTeacherProfile) as List)
              .map((teacher) => TeacherModel.fromJson(teacher))
              .toList();
          return teacherList;
        } else {
          throw Exception(
              "No internet connection and no cached data available");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> performGetRequest(String endpoint) async {
    try {
      final response = await _apiClient.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      await handleDioException(e);
      rethrow;
    }
  }
}
