import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/app/routes/api_routes.dart';
import 'package:nist_tes/core/model/college_wall_model.dart';
import 'package:nist_tes/core/utils/error_utils.dart';
import 'package:nist_tes/core/utils/logger_utils.dart';

import '../services/service_locator.dart';

class WallApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;

  Future<void> createPost(CollegeWallModel post) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Creating new wall post');
      await _apiClient.post(
        ApiRoutes.collegeWallPublic,
        data: post.toJson(),
      );
    } on DioException catch (e) {
      logger.e('DioException while creating post: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while creating post: $e');
      throw ServerException('Failed to create post: ${e.toString()}');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      if (!await _connectivityService.isConnected()) {
        throw const NoInternetException();
      }

      logger.i('Deleting wall post: $postId');
      await _apiClient.delete('${ApiRoutes.collegeWallPublic}/$postId');
    } on DioException catch (e) {
      logger.e('DioException while deleting post: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      logger.e('Unexpected error while deleting post: $e');
      throw ServerException('Failed to delete post: ${e.toString()}');
    }
  }

  Future<List<CollegeWallModel>> fetchCollegeWalls({int page = 1}) async {
    try {
      if (!await _connectivityService.isConnected()) {
        final cachedData = await _cacheService.getCollegeWall();
        if (cachedData != null) {
          logger.i('Fetching college walls from cache');
          return (jsonDecode(cachedData) as List)
              .map((w) => CollegeWallModel.fromJson(w))
              .toList();
        }
        throw const NoInternetException();
      }

      logger.i('Fetching college walls from API, page: $page');
      final response = await _apiClient.get(
        ApiRoutes.collegeWallPublic,
        queryParameters: {
          "limit": 10,
          "page": page,
        },
      );

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final collegeWallList = (response.data['data'] as List)
          .map((collegeWall) => CollegeWallModel.fromJson(collegeWall))
          .toList();

      // Cache only first page
      if (page == 1) {
        logger.i('Caching college walls');
        await _cacheService.storeCollegeWall(
          jsonEncode(collegeWallList.map((w) => w.toJson()).toList()),
        );
      }

      return collegeWallList;
    } on DioException catch (e) {
      logger.e('DioException while fetching college walls: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate existing AppExceptions
    } catch (e) {
      logger.e('Unexpected error while fetching college walls: $e');
      throw ServerException('Failed to fetch college walls: ${e.toString()}');
    }
  }
}
