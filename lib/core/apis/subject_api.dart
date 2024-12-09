import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app/const/app_constant.dart';
import '../../app/routes/api_routes.dart';
import '../model/subject_model.dart';
import '../services/service_locator.dart';
import '../utils/error_utils.dart';
import '../utils/logger_utils.dart';

class SubjectApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;

  Future<List<SubjectModel>> getSubjects() async {
    try {
      if (!await _connectivityService.isConnected()) {
        // Get subjects from cache
        final cachedSubjectProfile = await _cacheService.getSubjectProfile();
        if (cachedSubjectProfile != null) {
          logger.i('Fetching subjects from cache');
          final subjectList = (jsonDecode(cachedSubjectProfile) as List)
              .map((subject) => SubjectModel.fromJson(subject))
              .toList();
          return subjectList;
        } else {
          throw const NoInternetException();
        }
      }

      // Fetch subjects from API
      logger.i('Fetching subjects from API');
      final response =
          await _apiClient.get('${ApiRoutes.subjects}${AppConst.sectionId}');

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final subjectList = (response.data as List)
          .map((subject) => SubjectModel.fromJson(subject))
          .toList();

      // Store subjects in cache
      logger.i('Caching subjects data');
      await _cacheService.storeSubjectProfile(
        jsonEncode(subjectList.map((subject) => subject.toJson()).toList()),
      );

      return subjectList;
    } on DioException catch (e) {
      logger.e('DioException while fetching subjects: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate known exceptions
    } catch (e) {
      logger.e('Unexpected error while fetching subjects: $e');
      throw ServerException('Failed to fetch subjects: ${e.toString()}');
    }
  }
}
