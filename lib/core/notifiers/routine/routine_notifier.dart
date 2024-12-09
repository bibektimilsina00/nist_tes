import 'package:flutter/material.dart';

import '../../apis/routine_api.dart';
import '../../model/routine_model.dart';
import '../../utils/error_utils.dart';
import 'routine_state.dart';

class RoutineNotifier with ChangeNotifier {
  final RoutineApi _routineApi;
  RoutineState _state = const RoutineState();

  RoutineNotifier() : _routineApi = RoutineApi();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  List<RoutineModel> get routines => _state.routines;
  RoutineState get state => _state;

  void clearError() {
    _updateState(error: '');
  }

  Future<void> getRoutines({bool refresh = false}) async {
    _updateState(isLoading: true, error: '');
    try {
      final routines = await _routineApi.getRoutines();
      _updateState(routines: routines);
    } on AppException catch (e) {
      _updateState(error: e.message, routines: []);
    } catch (e) {
      _updateState(error: 'An unexpected error occurred', routines: []);
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    List<RoutineModel>? routines,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      routines: routines,
    );
    notifyListeners();
  }
}
