import 'package:json_annotation/json_annotation.dart';

part 'college_wall_model.g.dart';

@JsonSerializable()
class CollegeWallModel {
  final String id;
  final String content;
  final int? likeCount;
  final String? description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String? profileImageUrl;
  final List<String>? files;

  CollegeWallModel({
    required this.id,
    required this.content,
    this.likeCount,
    this.description,
    required this.createdAt,
    this.profileImageUrl,
    this.files,
  });

  factory CollegeWallModel.fromJson(Map<String, dynamic> json) =>
      _$CollegeWallModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollegeWallModelToJson(this);
}
