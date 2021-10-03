import 'package:tomorrow_diary/mixins/mixins.dart';

class CalendarUtil {
  final List<String> week = ['일', '월', '화', '수', '목', '금', '토'];

  CalendarUtil();

  static List<List<int>> daysForWeek(int year, int month) {
    int shift = DateTime.utc(year, month, 1).weekday % 7;
    int daysInMonth = _daysInMonth(year, month);
    List<int> _day = List.generate(daysInMonth, (index) => index + 1);
    return List.generate(
      7,
      (i) => List.generate(
          (shift + daysInMonth + 6) ~/ 7,
          (j) => (i + j * 7) < shift || (i + j * 7) >= shift + daysInMonth
              ? -1
              : i + j * 7 - shift + 1),
    );
  }

  // int today(int, int) : 오늘이 속한 달일 때 오늘이 며칠인지 알려줌.
  static bool isIncludeToday(int year, int month) {
    DateTime now = DateTime.now();
    if (now.year == year && now.month == month) {
      return true;
    }
    return false;
  }

  static int thisYear() {
    return DateTime.now().year;
  }

  static int thisMonth() {
    return DateTime.now().month;
  }

  static int thisDay() {
    return DateTime.now().day;
  }

  static int _daysInMonth(int year, int month) {
    List<int> monthLength = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (_leapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[month - 1];
  }

  static bool _leapYear(int year) {
    bool leapYear = false;
    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
