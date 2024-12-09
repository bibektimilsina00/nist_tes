import 'package:flutter/material.dart';
import 'package:nist_tes/core/utils/error_utils.dart';

import '../../apis/wall_api.dart';
import '../../model/college_wall_model.dart';
import 'wall_state.dart';

class WallNotifier extends ChangeNotifier {
  final WallApi _wallApi;
  WallState _state = const WallState();

  WallNotifier() : _wallApi = WallApi();

  String get error => _state.error;
  bool get isLoading => _state.isLoading;
  WallState get state => _state;
  List<CollegeWallModel> get walls => _state.walls;

  void clearError() {
    _state = _state.copyWith(error: '');
    notifyListeners();
  }

  Future<void> createPost(CollegeWallModel post) async {
    try {
      _state = _state.copyWith(isLoading: true, error: '');
      notifyListeners();

      await _wallApi.createPost(post);
      await getCollegeWalls(refresh: true);
    } on AppException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _state = _state.copyWith(isLoading: true, error: '');
      notifyListeners();

      await _wallApi.deletePost(postId);
      _state = _state.copyWith(
        walls: _state.walls.where((wall) => wall.id != postId).toList(),
        isLoading: false,
      );
    } on AppException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
    }
    notifyListeners();
  }

  Future<void> getCollegeWalls({bool refresh = false}) async {
    if (refresh) {
      _state = const WallState(isLoading: true);
    } else {
      _state = _state.copyWith(isLoading: true, error: '');
    }
    notifyListeners();

    try {
      final walls = await _wallApi.fetchCollegeWalls(
        page: refresh ? 1 : _state.currentPage,
      );

      if (refresh) {
        _state = WallState(
          walls: walls,
          currentPage: 1,
          hasMore: walls.length >= 10,
        );
      } else {
        _state = _state.copyWith(
          walls: [..._state.walls, ...walls],
          currentPage: _state.currentPage + 1,
          hasMore: walls.length >= 10,
          isLoading: false,
        );
      }
    } on NoInternetException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
    } on UnauthorizedException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
    } on ServerException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        error: 'Something went wrong',
        isLoading: false,
      );
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (!_state.isLoading && _state.hasMore) {
      await getCollegeWalls();
    }
  }

  Future<void> refresh() async {
    await getCollegeWalls(refresh: true);
  }
}
