import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Education {
  @JsonKey(includeToJson: false, defaultValue: '')
  final String id;

  final String institution;
  final String degree;
  final String period;
  final String location;
  final String skills;

  @JsonKey(defaultValue: false)
  final bool isCurrent;

  @JsonKey(defaultValue: '')
  final String logo;

  @JsonKey(defaultValue: 0)
  final int starCount;

  @JsonKey(defaultValue: false)
  final bool isStarred;

  @JsonKey(defaultValue: '')
  final String starredByNames;

  Education({
    this.id = '',
    required this.institution,
    required this.degree,
    required this.period,
    required this.location,
    required this.skills,
    this.isCurrent = false,
    this.logo = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  Map<String, dynamic> toJson() => _$EducationToJson(this);

  Map<String, dynamic> toCreateJson() => {
    'institution': institution,
    'degree': degree,
    'period': period,
    'location': location,
    'skills': skills,
    'is_current': isCurrent,
    'logo': logo,
  };
}
