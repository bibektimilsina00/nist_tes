import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static const String userProfileKey = 'userProfile';
  static const String teacherProfileKey = 'teacherProfile';
  static const String subjectProfileKey = 'subjectProfile';
  static const String routineProfileKey = 'routineProfile';

  final cacheManager = DefaultCacheManager();

  Future<void> clearRoutineProfile() async {
    await cacheManager.removeFile(routineProfileKey);
  }

  Future<void> clearSubjectProfile() async {
    await cacheManager.removeFile(subjectProfileKey);
  }

  Future<void> clearTeacherProfile() async {
    await cacheManager.removeFile(teacherProfileKey);
  }

  Future<void> clearUserProfile() async {
    await cacheManager.removeFile(userProfileKey);
  }

  Future<String?> getRoutineProfile() async {
    try {
      final file = await cacheManager.getSingleFile(routineProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getSubjectProfile() async {
    try {
      final file = await cacheManager.getSingleFile(subjectProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getTeacherProfile() async {
    try {
      final file = await cacheManager.getSingleFile(teacherProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserProfile() async {
    try {
      final file = await cacheManager.getSingleFile(userProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<void> storeRoutineProfile(String routineProfileJson) async {
    await cacheManager.putFile(
      routineProfileKey,
      Uint8List.fromList(routineProfileJson.codeUnits),
    );
  }

  Future<void> storeSubjectProfile(String subjectProfileJson) async {
    await cacheManager.putFile(
      subjectProfileKey,
      Uint8List.fromList(subjectProfileJson.codeUnits),
    );
  }

  Future<void> storeTeacherProfile(String teacherProfileJson) async {
    await cacheManager.putFile(
      teacherProfileKey,
      Uint8List.fromList(teacherProfileJson.codeUnits),
    );
  }

  Future<void> storeUserProfile(String userProfileJson) async {
    await cacheManager.putFile(
      userProfileKey,
      Uint8List.fromList(userProfileJson.codeUnits),
    );
  }
}