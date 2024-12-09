import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/app/const/app_constant.dart';

import '../../app/routes/api_routes.dart';
import '../model/teacher_model.dart';
import '../services/service_locator.dart';
import '../utils/error_utils.dart';
import '../utils/logger_utils.dart';

class TeacherApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;
  TeacherApi();

  Future<List<TeacherModel>> getTeachers() async {
    try {
      if (!await _connectivityService.isConnected()) {
        // Get teachers from cache
        final cachedTeacherProfile = await _cacheService.getTeacherProfile();
        if (cachedTeacherProfile != null) {
          logger.i('Fetching teachers from cache');
          final teacherList = (jsonDecode(cachedTeacherProfile) as List)
              .map((teacher) => TeacherModel.fromJson(teacher))
              .toList();
          return teacherList;
        } else {
          throw const NoInternetException();
        }
      }

      // Fetch teachers from API
      logger.i('Fetching teachers from API');
      final response =
          await _apiClient.get('${ApiRoutes.teachers}${AppConst.sectionId}');

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final teacherList = (response.data as List)
          .map((teacher) => TeacherModel.fromJson(teacher))
          .toList();

      // Store teachers in cache
      logger.i('Caching teacher data');
      await _cacheService.storeTeacherProfile(
        jsonEncode(teacherList.map((teacher) => teacher.toJson()).toList()),
      );

      return teacherList;
    } on DioException catch (e) {
      logger.e('DioException while fetching teachers: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate known exceptions
    } catch (e) {
      logger.e('Unexpected error while fetching teachers: $e');
      throw ServerException('Failed to fetch teachers: ${e.toString()}');
    }
  }
}
