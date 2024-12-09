import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app/const/app_constant.dart';
import '../../app/routes/api_routes.dart';
import '../model/routine_model.dart';
import '../services/service_locator.dart';
import '../utils/error_utils.dart';
import '../utils/logger_utils.dart';

class RoutineApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;

  RoutineApi();

  Future<List<RoutineModel>> getRoutines() async {
    try {
      if (!await _connectivityService.isConnected()) {
        // Get routines from cache
        final cachedRoutineProfile = await _cacheService.getRoutineProfile();
        if (cachedRoutineProfile != null) {
          logger.i('Fetching routines from cache');
          final routineList = (jsonDecode(cachedRoutineProfile) as List)
              .map((routine) => RoutineModel.fromJson(routine))
              .toList();
          return routineList;
        } else {
          throw const NoInternetException();
        }
      }

      // Fetch routines from API
      logger.i('Fetching routines from API');
      final response =
          await _apiClient.get('${ApiRoutes.routines}${AppConst.sectionId}');

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final routineList = (response.data as List)
          .map((routine) => RoutineModel.fromJson(routine))
          .toList();

      // Store routines in cache
      logger.i('Caching routine data');
      await _cacheService.storeRoutineProfile(
        jsonEncode(routineList.map((routine) => routine.toJson()).toList()),
      );

      return routineList;
    } on DioException catch (e) {
      logger.e('DioException while fetching routines: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate known exceptions
    } catch (e) {
      logger.e('Unexpected error while fetching routines: $e');
      throw ServerException('Failed to fetch routines: ${e.toString()}');
    }
  }
}
