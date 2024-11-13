import 'package:flutter/material.dart';

import '../../app/api_client/api_client.dart';
import '../apis/teacher_api.dart';
import '../model/teacher_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../utils/error_utils.dart';

class TeacherNotifier with ChangeNotifier {
  final TeacherApi _teacherApi;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  List<TeacherModel> _teacherList = [];

  TeacherNotifier(ApiClient apiClient, ConnectivityService connectivityService,
      CacheService cacheService)
      : _teacherApi = TeacherApi(apiClient, connectivityService, cacheService);

  String get errorMessage => _errorMessage;
  ValueNotifier<bool> get isLoading => _isLoading;
  List<TeacherModel> get teacherList => _teacherList;

  Future<void> getTeachers() async {
    _updateState(isLoading: true);
    try {
      _teacherList = await _teacherApi.getTeachers();
    } catch (e) {
      _errorMessage = getErrorMessage(e);
      _teacherList = [];
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
