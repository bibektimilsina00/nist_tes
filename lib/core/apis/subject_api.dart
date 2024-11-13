import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/app/const/app_constant.dart';

import '../../app/api_client/api_client.dart';
import '../../app/routes/api_routes.dart';
import '../../core/utils/error_utils.dart';
import '../model/subject_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

class SubjectApi {
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final CacheService _cacheService;

  SubjectApi(this._apiClient, this._connectivityService, this._cacheService);

  Future<List<SubjectModel>> getSubjects() async {
    try {
      if (await _connectivityService.isConnected()) {
        final response =
            await performGetRequest(ApiRoutes.subjects + AppConst.sectionId);
        final subjectList = (response)
            .map((subject) => SubjectModel.fromJson(subject))
            .toList();

        // Store subjects in cache
        await _cacheService.storeSubjectProfile(jsonEncode(
            subjectList.map((subject) => subject.toJson()).toList()));

        return subjectList;
      } else {
        // Get subjects from cache
        final cachedSubjectProfile = await _cacheService.getSubjectProfile();
        if (cachedSubjectProfile != null) {
          final subjectList = (jsonDecode(cachedSubjectProfile) as List)
              .map((subject) => SubjectModel.fromJson(subject))
              .toList();
          return subjectList;
        } else {
          throw Exception(
              "No internet connection and no cached data available");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> performGetRequest(
    String endpoint,
  ) async {
    try {
      final response = await _apiClient.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      await handleDioException(e);
      rethrow;
    }
  }
}
