// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineDetailModel _$RoutineDetailModelFromJson(Map<String, dynamic> json) =>
    RoutineDetailModel(
      id: json['id'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      room: json['room'] as String?,
      subject: SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoutineDetailModelToJson(RoutineDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'room': instance.room,
      'subject': instance.subject.toJson(),
    };

RoutineModel _$RoutineModelFromJson(Map<String, dynamic> json) => RoutineModel(
      id: json['id'] as String,
      name: json['name'] as String,
      routineDetails: (json['routineDetails'] as List<dynamic>)
          .map((e) => RoutineDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoutineModelToJson(RoutineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'routineDetails': instance.routineDetails.map((e) => e.toJson()).toList(),
    };
