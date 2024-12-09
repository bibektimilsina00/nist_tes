import 'package:flutter/material.dart';

import '../../apis/teacher_api.dart';
import '../../model/teacher_model.dart';
import '../../utils/error_utils.dart';
import 'teacher_state.dart';

class TeacherNotifier with ChangeNotifier {
  final TeacherApi _teacherApi;
  TeacherState _state = const TeacherState();

  TeacherNotifier() : _teacherApi = TeacherApi();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  TeacherState get state => _state;
  List<TeacherModel> get teachers => _state.teachers;

  void clearError() {
    _updateState(error: '');
  }

  Future<void> getTeachers() async {
    _updateState(isLoading: true, error: '');
    try {
      final teachers = await _teacherApi.getTeachers();
      _updateState(teachers: teachers);
    } on AppException catch (e) {
      _updateState(error: e.message, teachers: []);
    } catch (e) {
      _updateState(error: 'An unexpected error occurred', teachers: []);
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    List<TeacherModel>? teachers,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      teachers: teachers,
    );
    notifyListeners();
  }
}
