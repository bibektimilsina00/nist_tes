import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/api_client/api_client.dart';
import '../apis/auth_api.dart';
import '../utils/error_utils.dart';


class AuthenticationNotifier with ChangeNotifier {
  final AuthenticationAPI _authenticationAPI;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String _errorMessage = '';
  String userPhone = '';
  

  AuthenticationNotifier(ApiClient apiClient)
      : _authenticationAPI = AuthenticationAPI(apiClient);

  String get errorMessage => _errorMessage;
  ValueNotifier<bool> get isLoading => _isLoading;


  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    _updateState(isLoading: true);
    try {
      await _authenticationAPI.changePassword(
          currentPassword: oldPassword, newPassword: newPassword);
    } catch (e) {
      _errorMessage = getErrorMessage(e);
      rethrow;
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token?.isNotEmpty ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> sendOtp(
      {required String phone, String countryCode = '+977'}) async {
    _updateState(isLoading: true);
    try {
      final response = await _authenticationAPI.sendOtp(
          phone: phone, countryCode: countryCode);
      
    } catch (e) {
      _updateState(errorMessage: getErrorMessage(e));
    } finally {
      _updateState(isLoading: false);
    }
  }

  void setUserPhone(String phone) {
    userPhone = phone;
    notifyListeners();
  }

  

  Future<void> userLogin({
    required String userEmail,
    required String userPassword,
  }) async {
    _updateState(isLoading: true);
    try {
      final token = await _authenticationAPI.userLogin(
          userEmail: userEmail, userPassword: userPassword);
      if (token.isNotEmpty) {
        await _setToken(token);
      }
    } catch (e) {
      _updateState(errorMessage: getErrorMessage(e));
      rethrow;
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> verifyOtp({required String phone, required String otp}) async {
    _updateState(isLoading: true);
    try {
      final response =
          await _authenticationAPI.verifyOtp(phone: phone, otp: otp);
      await _setToken(response['access_token']);
    } catch (e) {
      _updateState(errorMessage: getErrorMessage(e));
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> _setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void _updateState({bool isLoading = false, String errorMessage = ''}) {
    _isLoading.value = isLoading;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}