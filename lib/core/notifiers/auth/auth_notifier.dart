import 'package:flutter/material.dart';
import 'package:nist_tes/core/apis/auth_api.dart';
import 'package:nist_tes/core/utils/error_utils.dart';
import 'package:nist_tes/core/utils/shared_preferences_util.dart';

import 'auth_state.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI;
  AuthState _state = const AuthState();

  AuthenticationNotifier() : _authenticationAPI = AuthenticationAPI();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  bool get isLoggedIn => _state.isLoggedIn;
  AuthState get state => _state;
  String get userPhone => _state.userPhone;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    _updateState(isLoading: true, error: '');
    try {
      await _authenticationAPI.changePassword(
        currentPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AppException catch (e) {
      _updateState(error: e.message);
    } catch (_) {
      _updateState(error: 'An unexpected error occurred');
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> checkLoginStatus() async {
    final token = await SharedPreferencesUtil().getToken();
    _updateState(isLoggedIn: token?.isNotEmpty ?? false);
  }

  void clearError() {
    _updateState(error: '');
  }

  Future<bool> isFirstTimeUse() async {
    final isFirstTime = await SharedPreferencesUtil().getIsFirstTime();
    if (isFirstTime) {
      await SharedPreferencesUtil().setIsFirstTime(false);
    }
    return isFirstTime;
  }

  Future<void> logout() async {
    await SharedPreferencesUtil().clearToken();
    _updateState(isLoggedIn: false);
  }

  Future<void> sendOtp({
    required String phone,
    String countryCode = '+977',
  }) async {
    _updateState(isLoading: true, error: '');
    try {
      await _authenticationAPI.sendOtp(phone: phone, countryCode: countryCode);
      _updateState(userPhone: phone);
    } on AppException catch (e) {
      _updateState(error: e.message);
    } catch (_) {
      _updateState(error: 'An unexpected error occurred');
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> userLogin({
    required String userEmail,
    required String userPassword,
  }) async {
    _updateState(isLoading: true, error: '');
    try {
      final token = await _authenticationAPI.userLogin(
        userEmail: userEmail,
        userPassword: userPassword,
      );
      await _setToken(token);
      _updateState(isLoggedIn: true);
    } on AppException catch (e) {
      _updateState(error: e.message);
    } catch (_) {
      _updateState(error: 'An unexpected error occurred');
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    _updateState(isLoading: true, error: '');
    try {
      final token = await _authenticationAPI.verifyOtp(
        phone: phone,
        otp: otp,
      );

      // await _setToken(token);

      _updateState(isLoggedIn: true);
    } on AppException catch (e) {
      _updateState(error: e.message);
    } catch (_) {
      _updateState(error: 'An unexpected error occurred');
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future _setToken(String token) async {
    await SharedPreferencesUtil().setToken(token);
  }

  void _updateState({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    String? userPhone,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      isLoggedIn: isLoggedIn,
      userPhone: userPhone,
    );
    notifyListeners();
  }
}
