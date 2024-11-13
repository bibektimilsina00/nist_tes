import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'section_model.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String batch;
  @HiveField(2)
  final SectionModel section;

  StudentModel({
    required this.id,
    required this.batch,
    required this.section,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
