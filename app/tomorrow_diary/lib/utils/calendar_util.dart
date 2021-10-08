enum TimePoint { past, present, tomorrow, future }

class CalendarUtil {
  static final List<String> week = ['일', '월', '화', '수', '목', '금', '토'];

  CalendarUtil();

  static List<int> dayListForMonth(int year, int month) {
    int shift = DateTime.utc(year, month, 1).weekday % 7;
    int daysInMonth = daysCount(year, month);
    List<int> ret = List.generate(shift, (index) => -1);
    List<int> _day = List.generate(daysInMonth, (index) => index + 1);
    ret.addAll(_day);
    return ret;
  }

  // int today(int, int) : 오늘이 속한 달일 때 오늘이 며칠인지 알려줌.
  static bool isIncludeToday(int year, int month) {
    DateTime now = DateTime.now();
    if (now.year == year && now.month == month) {
      return true;
    }
    return false;
  }

  // 입력 받은게 past : -1, present : 0, future : 1
  static TimePoint decidePastPresentFuture(int year, int month, int day) {
    if (thisYear() < year) {
      return TimePoint.future;
    } else if (thisYear() > year) {
      return TimePoint.past;
    } else {
      if (thisMonth() < month) {
        return TimePoint.future;
      } else if (thisMonth() > month) {
        return TimePoint.past;
      } else {
        if (thisDay() < day) {
          if (thisDay() + 1 == day) {
            return TimePoint.tomorrow;
          } else {
            return TimePoint.future;
          }
        } else if (thisDay() > day) {
          return TimePoint.past;
        } else {
          return TimePoint.present;
        }
      }
    }
  }

  static TimePoint decidePastPresentFutureWithDate(String date) {
    List<int> temp = date.split('-').map((e) => int.parse(e)).toList();
    return decidePastPresentFuture(temp[0], temp[1], temp[2]);
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

  static int daysCount(int year, int month) {
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
