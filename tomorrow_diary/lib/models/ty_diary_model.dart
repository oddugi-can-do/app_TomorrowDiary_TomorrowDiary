import 'dart:convert';

import 'package:tomorrow_diary/models/models.dart';

class TyDiary {
  TyDiary({
    this.title,
    this.tyEmotion,
    this.tyHappen,
    this.tySurprise,
    this.tyWish,
  });

  String? title;
  String? tyEmotion;
  String? tyHappen;
  String? tySurprise;
  List<Wish>? tyWish;

  bool isEmpty() {
    if (title == null || title == '') {
      if (tyEmotion == null || tyEmotion == '') {
        if (tyHappen == null || tyHappen == '') {
          if (tySurprise == null || tySurprise == '') {
            if (tyWish == null || tyWish!.isEmpty) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  factory TyDiary.fromJson(String str) => TyDiary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TyDiary.fromMap(Map<String, dynamic> json) => TyDiary(
        title: json["title"] == null ? null : json["title"],
        tyEmotion: json["ty_emotion"] == null ? null : json["ty_emotion"],
        tyHappen: json["ty_happen"] == null ? null : json["ty_happen"],
        tySurprise: json["ty_surprise"] == null ? null : json["ty_surprise"],
        tyWish: json["ty_wish"] == null
            ? null
            : List<Wish>.from(json["ty_wish"].map((x) => Wish.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "ty_emotion": tyEmotion == null ? null : tyEmotion,
        "ty_happen": tyHappen == null ? null : tyHappen,
        "ty_surprise": tySurprise == null ? null : tySurprise,
        "ty_wish": tyWish == null
            ? null
            : List<dynamic>.from(tyWish!.map((x) => x.toMap())),
      };
}
