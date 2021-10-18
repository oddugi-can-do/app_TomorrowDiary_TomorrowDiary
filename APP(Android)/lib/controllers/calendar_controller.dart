import 'package:get/get.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'controllers.dart';

class CalendarController extends GetxController {
  int _selectedYear = CalendarUtil.thisYear();
  int _selectedMonth = CalendarUtil.thisMonth();
  int _selectedDay = CalendarUtil.thisDay();
  get selectedYear => _selectedYear;
  get selectedMonth => _selectedMonth;
  get selectedDay => _selectedDay;
  String get selectedDate =>
      DateConverter.dateToString(_selectedYear, _selectedMonth, _selectedDay);

  DiaryController _d = Get.find();

  void selectDay(int day) {
    _selectedDay = day;
    _d.findDataByDate(selectedDate);
    update();
  }

  void selectYearAndMonth(int year, int month) {
    _selectedDay = 1;
    _selectedYear = year;
    _selectedMonth = month;
    _d.findDataByDate(selectedDate);
  }

  bool isSelected(int day) {
    return day == _selectedDay;
  }
}
