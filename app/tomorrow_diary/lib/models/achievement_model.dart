import 'dart:convert';

//Achievements 는 List<Achievement> 이다.
class Achievements {
  Achievements({
    required this.achievements,
  });

  List<Achievement> achievements;

  factory Achievements.fromJson(String str) =>
      Achievements.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Achievements.fromMap(Map<String, dynamic> json) => Achievements(
        achievements: json["achievements"] = List<Achievement>.from(
            json["achievements"].map((x) => Achievement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "achievements": List<dynamic>.from(achievements.map((x) => x.toMap())),
      };
}

class Achievement {
  Achievement({
    this.title = '',
    this.description = '',
  });

  String title;
  String description;

  factory Achievement.fromJson(String str) =>
      Achievement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Achievement.fromMap(Map<String, dynamic> json) => Achievement(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
