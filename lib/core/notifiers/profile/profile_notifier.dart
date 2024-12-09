import 'package:flutter/material.dart';

import '../../apis/profile_api.dart';
import '../../model/user_model.dart';
import '../../utils/error_utils.dart';
import 'profile_state.dart';

class ProfileNotifier with ChangeNotifier {
  final ProfileApi _profileApi;
  ProfileState _state = const ProfileState();

  ProfileNotifier() : _profileApi = ProfileApi();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  ProfileState get state => _state;
  UserModel? get userProfile => _state.userProfile;

  void clearError() {
    _updateState(error: '');
  }

  Future<void> getMyProfile() async {
    _updateState(isLoading: true, error: '');
    try {
      final profile = await _profileApi.getMyProfile();
      _updateState(userProfile: profile);
    } on AppException catch (e) {
      _updateState(error: e.message, userProfile: null);
    } catch (e) {
      _updateState(error: 'An unexpected error occurred', userProfile: null);
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    UserModel? userProfile,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      userProfile: userProfile,
    );
    notifyListeners();
  }
}
