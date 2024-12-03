import 'dart:convert';

import 'package:nist_tes/app/api_client/api_client.dart';
import 'package:nist_tes/app/routes/api_routes.dart';
import 'package:nist_tes/core/model/college_wall_model.dart';
import 'package:nist_tes/core/utils/logger_utils.dart';

import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

class WallApi {
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final CacheService _cacheService;
  WallApi(this._apiClient, this._connectivityService, this._cacheService);

  Future<List<CollegeWallModel>> fetchCollegeWalls() async {
    try {
      if (await _connectivityService.isConnected()) {
        final response =
            await _apiClient.get(ApiRoutes.collegeWallPublic, queryParameters: {
          "limit": 10,
          "page": 1,
        });

        final collegeWallList = (response.data['data'] as List)
            .map((collegeWall) => CollegeWallModel.fromJson(collegeWall))
            .toList();

        await _cacheService.storeCollegeWall(jsonEncode(collegeWallList
            .map((collegeWall) => collegeWall.toJson())
            .toList()));

        return collegeWallList;
      } else {
        final cachedCollegeWall = await _cacheService.getCollegeWall();
        if (cachedCollegeWall != null) {
          final collegeWallList = (jsonDecode(cachedCollegeWall) as List)
              .map((collegeWall) => CollegeWallModel.fromJson(collegeWall))
              .toList();
          return collegeWallList;
        } else {
          throw Exception(
              "No internet connection and no cached data available");
        }
      }
    } catch (e) {
      logger.e(e);
    }
    return [];
  }
}
