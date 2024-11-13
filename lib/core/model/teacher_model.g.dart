// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
      id: json['id'] as String,
      joinDate: DateTime.parse(json['join_date'] as String),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      designation: json['designation'] == null
          ? null
          : DesignationModel.fromJson(
              json['designation'] as Map<String, dynamic>),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'join_date': instance.joinDate.toIso8601String(),
      'user': instance.user.toJson(),
      'designation': instance.designation?.toJson(),
      'subjects': instance.subjects?.map((e) => e.toJson()).toList(),
    };
