import 'package:flutter/material.dart';

import '../../app/api_client/api_client.dart';
import '../apis/subject_api.dart';
import '../model/subject_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../utils/error_utils.dart';

class SubjectNotifier with ChangeNotifier {
  final SubjectApi _subjectApi;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  List<SubjectModel> _subjectList = [];

  SubjectNotifier(ApiClient apiClient, ConnectivityService connectivityService,
      CacheService cacheService)
      : _subjectApi = SubjectApi(apiClient, connectivityService, cacheService) {
    // _loadSubjects();
  }

  String get errorMessage => _errorMessage;
  ValueNotifier<bool> get isLoading => _isLoading;
  List<SubjectModel> get subjectList => _subjectList;

  Future<void> getSubjects() async {
    _updateState(isLoading: true);
    try {
      _subjectList = await _subjectApi.getSubjects();
    } catch (e) {
      _errorMessage = getErrorMessage(e);
      _subjectList = [];
    } finally {
      _updateState(isLoading: false);
    }
  }

  // void _loadSubjects() async {
  //   final cachedSubjectProfile =
  //       await _subjectApi._cacheService.getSubjectProfile();
  //   if (cachedSubjectProfile != null) {
  //     _subjectList = (jsonDecode(cachedSubjectProfile) as List)
  //         .map((subject) => SubjectModel.fromJson(subject))
  //         .toList();
  //   }
  //   notifyListeners();
  // }

  void _updateState({bool isLoading = false, String errorMessage = ''}) {
    _isLoading.value = isLoading;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
