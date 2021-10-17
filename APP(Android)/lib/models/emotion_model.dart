import 'dart:convert';
import 'package:get/state_manager.dart';


class EmotionModel  {
  final emotion = [];

  void updateEmotion(String body) {
    List emotionList = jsonDecode(body);
    for(dynamic i in emotionList) {
      emotion.add(i);
    }
  }
}