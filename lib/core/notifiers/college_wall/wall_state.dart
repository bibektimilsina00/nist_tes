import '../../model/college_wall_model.dart';

class WallState {
  final bool isLoading;
  final String error;
  final List<CollegeWallModel> walls;
  final bool hasMore;
  final int currentPage;

  const WallState({
    this.isLoading = false,
    this.error = '',
    this.walls = const [],
    this.hasMore = true,
    this.currentPage = 1,
  });

  WallState copyWith({
    bool? isLoading,
    String? error,
    List<CollegeWallModel>? walls,
    bool? hasMore,
    int? currentPage,
  }) {
    return WallState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      walls: walls ?? this.walls,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
