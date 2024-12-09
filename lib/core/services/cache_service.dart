import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static const String userProfileKey = 'userProfile';
  static const String teacherProfileKey = 'teacherProfile';
  static const String subjectProfileKey = 'subjectProfile';
  static const String routineProfileKey = 'routineProfile';
  static const String collegeWallKey = 'collegeWall';
  static const String eventKey = 'event';

  final cacheManager = DefaultCacheManager();
  //clearCollegeWall
  Future<void> clearCollegeWall() async {
    await cacheManager.removeFile(collegeWallKey);
  }

  //clearCollegeWall
  Future<void> clearRoutineProfile() async {
    await cacheManager.removeFile(routineProfileKey);
  }

  //clearCollegeWall
  Future<void> clearSubjectProfile() async {
    await cacheManager.removeFile(subjectProfileKey);
  }

  //clearTeacherProfile
  Future<void> clearTeacherProfile() async {
    await cacheManager.removeFile(teacherProfileKey);
  }

  //clearUserProfile
  Future<void> clearUserProfile() async {
    await cacheManager.removeFile(userProfileKey);
  }

  //getCollegeWall
  Future<String?> getCollegeWall() async {
    try {
      final file = await cacheManager.getSingleFile(collegeWallKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // getRoutineProfile
  Future<String?> getRoutineProfile() async {
    try {
      final file = await cacheManager.getSingleFile(routineProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // getEvent
  Future<String?> getEvent() async {
    try {
      final file = await cacheManager.getSingleFile(eventKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // getSubjectProfile
  Future<String?> getSubjectProfile() async {
    try {
      final file = await cacheManager.getSingleFile(subjectProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // getTeacherProfile
  Future<String?> getTeacherProfile() async {
    try {
      final file = await cacheManager.getSingleFile(teacherProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // getUserProfile
  Future<String?> getUserProfile() async {
    try {
      final file = await cacheManager.getSingleFile(userProfileKey);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  // storeCollegeWall
  Future<void> storeCollegeWall(String collegeWallJson) async {
    await cacheManager.putFile(
      collegeWallKey,
      Uint8List.fromList(collegeWallJson.codeUnits),
    );
  }

  // storeRoutineProfile
  Future<void> storeRoutineProfile(String routineProfileJson) async {
    await cacheManager.putFile(
      routineProfileKey,
      Uint8List.fromList(routineProfileJson.codeUnits),
    );
  }
  // storeEvent
  Future<void> storeEvent(String eventJson) async {
    await cacheManager.putFile(
      eventKey,
      Uint8List.fromList(eventJson.codeUnits),
    );
  }

  // storeSubjectProfile
  Future<void> storeSubjectProfile(String subjectProfileJson) async {
    await cacheManager.putFile(
      subjectProfileKey,
      Uint8List.fromList(subjectProfileJson.codeUnits),
    );
  }

  // storeTeacherProfile
  Future<void> storeTeacherProfile(String teacherProfileJson) async {
    await cacheManager.putFile(
      teacherProfileKey,
      Uint8List.fromList(teacherProfileJson.codeUnits),
    );
  }

  // storeUserProfile
  Future<void> storeUserProfile(String userProfileJson) async {
    await cacheManager.putFile(
      userProfileKey,
      Uint8List.fromList(userProfileJson.codeUnits),
    );
  }
}
