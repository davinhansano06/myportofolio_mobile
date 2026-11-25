import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable()
class Education {
  final String id;
  final String institution;
  final String degree;
  final String period;
  final String location;
  final String skills;
  @JsonKey(name: 'is_current')
  final bool isCurrent;
  final String logo;
  @JsonKey(name: 'star_count')
  final int starCount;
  @JsonKey(name: 'is_starred')
  final bool isStarred;
  @JsonKey(name: 'starred_by_names')
  final String starredByNames;

  Education({
    required this.id,
    required this.institution,
    required this.degree,
    required this.period,
    required this.location,
    required this.skills,
    required this.isCurrent,
    required this.logo,
    required this.starCount,
    required this.isStarred,
    required this.starredByNames,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}