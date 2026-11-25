import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  final String id;
  final String title;
  final String institution;
  final String period;
  final String description;
  final String image;
  @JsonKey(name: 'star_count')
  final int starCount;
  @JsonKey(name: 'is_starred')
  final bool isStarred;

  Experience({
    required this.id,
    required this.title,
    required this.institution,
    required this.period,
    required this.description,
    required this.image,
    required this.starCount,
    required this.isStarred,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}