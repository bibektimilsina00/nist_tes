// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_wall_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeWallModel _$CollegeWallModelFromJson(Map<String, dynamic> json) =>
    CollegeWallModel(
      id: json['id'] as String,
      content: json['content'] as String,
      likeCount: (json['likeCount'] as num?)?.toInt(),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      profileImageUrl: json['profileImageUrl'] as String?,
      files:
          (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CollegeWallModelToJson(CollegeWallModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'profileImageUrl': instance.profileImageUrl,
      'files': instance.files,
    };
