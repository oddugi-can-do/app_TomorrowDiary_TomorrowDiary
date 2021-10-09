import 'package:flutter/material.dart';

class TimeConverter {
  static int hourParser(String string) {
    return int.parse(string.split(":")[0]);
  }

  static int minuteParser(String string) {
    return int.parse(string.split(":")[1]);
  }

  static String timeOfDayToString(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  static TimeOfDay stringToTimeOfDay(String string) {
    var splitted = string.split(":");
    return TimeOfDay(
        hour: int.parse(splitted[0]), minute: int.parse(splitted[1]));
  }
}
