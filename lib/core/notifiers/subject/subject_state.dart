import '../../model/subject_model.dart';

class SubjectState {
  final bool isLoading;
  final String error;
  final List<SubjectModel> subjects;

  const SubjectState({
    this.isLoading = false,
    this.error = '',
    this.subjects = const [],
  });

  SubjectState copyWith({
    bool? isLoading,
    String? error,
    List<SubjectModel>? subjects,
  }) {
    return SubjectState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      subjects: subjects ?? this.subjects,
    );
  }
}
