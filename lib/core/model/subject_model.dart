import 'package:json_annotation/json_annotation.dart';
import 'package:nist_tes/core/model/teacher_model.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  final String id;
  final String name;
  final String subjectCode;
  final TeacherModel? teacher;

  SubjectModel({
    required this.id,
    required this.name,
    required this.subjectCode,
    this.teacher,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
