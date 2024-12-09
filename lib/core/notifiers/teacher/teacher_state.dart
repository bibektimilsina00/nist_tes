import '../../model/teacher_model.dart';

class TeacherState {
  final bool isLoading;
  final String error;
  final List<TeacherModel> teachers;

  const TeacherState({
    this.isLoading = false,
    this.error = '',
    this.teachers = const [],
  });

  TeacherState copyWith({
    bool? isLoading,
    String? error,
    List<TeacherModel>? teachers,
  }) {
    return TeacherState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      teachers: teachers ?? this.teachers,
    );
  }
}
