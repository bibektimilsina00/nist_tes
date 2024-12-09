import '../../model/routine_model.dart';

class RoutineState {
  final bool isLoading;
  final String error;
  final List<RoutineModel> routines;

  const RoutineState({
    this.isLoading = false,
    this.error = '',
    this.routines = const [],
  });

  RoutineState copyWith({
    bool? isLoading,
    String? error,
    List<RoutineModel>? routines,
  }) {
    return RoutineState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      routines: routines ?? this.routines,
    );
  }
}
