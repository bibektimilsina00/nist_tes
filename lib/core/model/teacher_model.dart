import 'package:json_annotation/json_annotation.dart';
import 'package:nist_tes/core/model/designation_model.dart';

import 'subject_model.dart';
import 'user_model.dart';

part 'teacher_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeacherModel {
  final String id;
  @JsonKey(name: 'join_date')
  final DateTime joinDate;
  final UserModel user;
  final DesignationModel? designation;
  final List<SubjectModel>? subjects;

  TeacherModel({
    required this.id,
    required this.joinDate,
    required this.user,
    required this.designation,
    required this.subjects,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}
