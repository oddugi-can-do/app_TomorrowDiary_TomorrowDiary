import 'dart:convert';

import 'package:tomorrow_diary/models/models.dart';

class TmrDiary {
  TmrDiary({
    this.title,
    this.tmrEmotion,
    this.tmrHappen,
    this.tmrWish,
  });

  String? title;
  String? tmrEmotion;
  String? tmrHappen;
  List<Wish>? tmrWish;

  bool isEmpty() {
    if (title == null || title == '') {
      if (tmrEmotion == null || tmrEmotion == '') {
        if (tmrHappen == null || tmrHappen == '') {
          if (tmrWish == null || tmrWish!.isEmpty) {
            return true;
          }
        }
      }
    }
    return false;
  }

  factory TmrDiary.fromJson(String str) => TmrDiary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TmrDiary.fromMap(Map<String, dynamic> json) => TmrDiary(
        title: json["title"] == null ? null : json["title"],
        tmrEmotion: json["tmr_emotion"] == null ? null : json["tmr_emotion"],
        tmrHappen: json["tmr_happen"] == null ? null : json["tmr_happen"],
        tmrWish: json["tmr_wish"] == null
            ? null
            : List<Wish>.from(json["tmr_wish"].map((x) => Wish.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "tmr_emotion": tmrEmotion == null ? null : tmrEmotion,
        "tmr_happen": tmrHappen == null ? null : tmrHappen,
        "tmr_wish": tmrWish == null
            ? null
            : List<dynamic>.from(tmrWish!.map((x) => x.toMap())),
      };
}
