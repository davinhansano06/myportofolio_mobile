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
    this.id = '',
    required this.title,
    this.institution = '',
    this.period = '',
    required this.description,
    this.image = '',
    this.starCount = 0,
    this.isStarred = false,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  Map<String, dynamic> toCreateJson() => {
    'title': title,
    'institution': institution,
    'period': period,
    'description': description,
    'image': image,
  };
}
