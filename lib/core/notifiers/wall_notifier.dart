import 'package:flutter/material.dart';
import 'package:nist_tes/core/apis/wall_api.dart';
import 'package:nist_tes/core/model/college_wall_model.dart';
import 'package:nist_tes/core/utils/logger_utils.dart';

import '../../app/api_client/api_client.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

class WallNotifier extends ChangeNotifier {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  List<CollegeWallModel> _collegeWallList = [];
  final WallApi _wallApi;

  WallNotifier(ApiClient apiClient, ConnectivityService connectivityService,
      CacheService cacheService)
      : _wallApi = WallApi(apiClient, connectivityService, cacheService);
  List<CollegeWallModel> get collegeWallList => _collegeWallList;
  String get errorMessage => _errorMessage;

  ValueNotifier<bool> get isLoading => _isLoading;

  // Get College Walls
  Future<void> getCollegeWalls() async {
    _updateState(isLoading: true);
    try {
      _collegeWallList = await _wallApi.fetchCollegeWalls();
    } catch (e) {
      logger.e(e);
      _errorMessage = e.toString();
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({bool isLoading = false, String errorMessage = ''}) {
    _isLoading.value = isLoading;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
