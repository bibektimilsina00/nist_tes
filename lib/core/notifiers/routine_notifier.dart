import 'package:flutter/material.dart';

import '../../app/api_client/api_client.dart';
import '../apis/routine_api.dart';
import '../model/routine_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../utils/error_utils.dart';

class RoutineNotifier with ChangeNotifier {
  final RoutineApi _routineApi;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  List<RoutineModel> _routineList = [];

  RoutineNotifier(ApiClient apiClient, ConnectivityService connectivityService,
      CacheService cacheService)
      : _routineApi = RoutineApi(apiClient, connectivityService, cacheService);

  String get errorMessage => _errorMessage;
  ValueNotifier<bool> get isLoading => _isLoading;
  List<RoutineModel> get routineList => _routineList;

  Future<void> getRoutines() async {
    _updateState(isLoading: true);
    try {
      _routineList = await _routineApi.getRoutines();
    } catch (e) {
      _errorMessage = getErrorMessage(e);
      _routineList = [];
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
