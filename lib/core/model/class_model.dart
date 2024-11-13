import 'package:json_annotation/json_annotation.dart';

part 'class_model.g.dart';

@JsonSerializable()
class ClassModel {
  final String id;
  final String name;
  final int? noOfStudents;

  final FacultyModel? faculty;

  ClassModel({
    required this.id,
    required this.name,
    this.noOfStudents,
    required this.faculty,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}

@JsonSerializable()
class FacultyModel {
  final String id;
  final String name;
  final LevelModel level;

  FacultyModel({
    required this.id,
    required this.name,
    required this.level,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) =>
      _$FacultyModelFromJson(json);
  Map<String, dynamic> toJson() => _$FacultyModelToJson(this);
}

@JsonSerializable()
class LevelModel {
  final String id;
  final String name;

  LevelModel({
    required this.id,
    required this.name,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
