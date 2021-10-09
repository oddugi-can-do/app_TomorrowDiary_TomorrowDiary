// To parse this JSON data, do
//
//     final achivements = achivementsFromMap(jsonString);

import 'dart:convert';

class Achievements {
  Achievements({
    this.achievements,
  });

  List<Achievement>? achievements;

  factory Achievements.fromJson(String str) =>
      Achievements.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Achievements.fromMap(Map<String, dynamic> json) => Achievements(
        achievements: json["Achievements"] == null
            ? null
            : List<Achievement>.from(
                json["Achievements"].map((x) => Achievement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Achievements": achievements == null
            ? null
            : List<dynamic>.from(achievements!.map((x) => x.toMap())),
      };
}

class Achievement {
  Achievement({
    this.title,
    this.description,
    this.gradeString,
  });

  String? title;
  String? description;
  String? gradeString;
  AchievementGrade get grade => gradeString == "gold"
      ? AchievementGrade.gold
      : gradeString == "silver"
          ? AchievementGrade.silver
          : AchievementGrade.bronze;

  factory Achievement.fromJson(String str) =>
      Achievement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Achievement.fromMap(Map<String, dynamic> json) => Achievement(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        gradeString: json["gradeString"] == null ? null : json["gradeString"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "gradeString": gradeString == null ? null : gradeString,
      };
}

enum AchievementType { welcome, openTmrDiary, army }

class AchievementManager {
  static Map<AchievementType, List<dynamic>> allAchievement = {
    AchievementType.welcome: [
      "<환영합니다>",
      "처음 가입하셨습니다",
      "gold",
    ],
    AchievementType.openTmrDiary: [
      "<내일설계자>",
      "내일을 설계하는 첫 걸음",
      "silver",
    ],
    AchievementType.army: [
      "<군대 취업>",
      "당신은 이제 군인입니다.",
      "bronze",
    ],
  };
}

enum AchievementGrade { gold, silver, bronze }
