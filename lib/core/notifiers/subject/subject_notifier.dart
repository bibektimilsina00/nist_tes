import 'package:flutter/material.dart';

import '../../apis/subject_api.dart';
import '../../model/subject_model.dart';
import '../../utils/error_utils.dart';
import 'subject_state.dart';

class SubjectNotifier with ChangeNotifier {
  final SubjectApi _subjectApi;
  SubjectState _state = const SubjectState();

  SubjectNotifier() : _subjectApi = SubjectApi();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  SubjectState get state => _state;
  List<SubjectModel> get subjects => _state.subjects;

  void clearError() {
    _updateState(error: '');
  }

  Future<void> getSubjects() async {
    _updateState(isLoading: true, error: '');
    try {
      final subjects = await _subjectApi.getSubjects();
      _updateState(subjects: subjects);
    } on AppException catch (e) {
      _updateState(error: e.message, subjects: []);
    } catch (e) {
      _updateState(error: 'An unexpected error occurred', subjects: []);
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    List<SubjectModel>? subjects,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      subjects: subjects,
    );
    notifyListeners();
  }
}
