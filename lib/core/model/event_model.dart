import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final String id;
  final String title;
  final String description;

  @JsonKey(name: 'startDate')
  final DateTime? startDate;

  @JsonKey(name: 'endDate')
  final DateTime? endDate;

  final String location;

  @JsonKey(name: 'is_public')
  final bool isPublic;

  @JsonKey(defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'responsiblePerson')
  final String? responsiblePerson;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.isPublic,
    required this.images,
    this.responsiblePerson,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    bool? isPublic,
    List<String>? images,
    String? responsiblePerson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      isPublic: isPublic ?? this.isPublic,
      images: images ?? this.images,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
