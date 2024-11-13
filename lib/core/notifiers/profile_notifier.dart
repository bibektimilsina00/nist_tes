import 'package:flutter/material.dart';

import '../../app/api_client/api_client.dart';
import '../apis/profile_api.dart';
import '../model/user_model.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../utils/error_utils.dart';

class ProfileNotifier with ChangeNotifier {
  final ProfileApi _profileApi;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  UserModel? _userProfile;

  ProfileNotifier(ApiClient apiClient, ConnectivityService connectivityService,
      CacheService cacheService)
      : _profileApi = ProfileApi(apiClient, connectivityService, cacheService);

  String get errorMessage => _errorMessage;
  ValueNotifier<bool> get isLoading => _isLoading;
  UserModel? get userProfile => _userProfile;

  Future<void> getMyProfile() async {
    _updateState(isLoading: true);
    try {
      _userProfile = await _profileApi.getMyProfile();
    } catch (e) {
      _errorMessage = getErrorMessage(e);
      _userProfile = null;
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
