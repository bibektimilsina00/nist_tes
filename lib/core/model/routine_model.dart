import 'package:json_annotation/json_annotation.dart';

import 'subject_model.dart';

part 'routine_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoutineDetailModel {
  final String id;
  final String startTime;
  final String endTime;
  final String? room;
  final SubjectModel subject;

  RoutineDetailModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.subject,
  });

  factory RoutineDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RoutineModel {
  final String id;
  final String name;

  final List<RoutineDetailModel> routineDetails;

  RoutineModel({
    required this.id,
    required this.name,
    required this.routineDetails,
  });

  factory RoutineModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineModelToJson(this);
}
