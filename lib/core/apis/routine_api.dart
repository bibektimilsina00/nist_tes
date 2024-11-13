import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app/api_client/api_client.dart';
import '../../app/const/app_constant.dart';
import '../../app/routes/api_routes.dart';
import '../../core/utils/error_utils.dart';
import '../model/routine_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

class RoutineApi {
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final CacheService _cacheService;

  RoutineApi(this._apiClient, this._connectivityService, this._cacheService);

  Future<List<RoutineModel>> getRoutines() async {
    try {
      if (await _connectivityService.isConnected()) {
        final response =
            await performGetRequest(ApiRoutes.routines + AppConst.sectionId);
        final routineList = (response)
            .map((routine) => RoutineModel.fromJson(routine))
            .toList();

        // Store routines in cache
        await _cacheService.storeRoutineProfile(jsonEncode(
            routineList.map((routine) => routine.toJson()).toList()));

        return routineList;
      } else {
        // Get routines from cache
        final cachedRoutineProfile = await _cacheService.getRoutineProfile();
        if (cachedRoutineProfile != null) {
          final routineList = (jsonDecode(cachedRoutineProfile) as List)
              .map((routine) => RoutineModel.fromJson(routine))
              .toList();
          return routineList;
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
