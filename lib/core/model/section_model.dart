import 'package:json_annotation/json_annotation.dart';

import 'class_model.dart';

part 'section_model.g.dart';

@JsonSerializable()
class SectionModel {
  final String id;
  final String name;
  @JsonKey(name: 'class')
  final ClassModel? classModel;

  SectionModel({
    required this.id,
    required this.name,
    this.classModel,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
