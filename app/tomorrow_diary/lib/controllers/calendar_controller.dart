import 'package:get/get.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/utils.dart';

import 'controllers.dart';

class CalendarController extends GetxController with PrintLogMixin {
  int _selectedYear = CalendarUtil.thisYear();
  int _selectedMonth = CalendarUtil.thisMonth();
  int _selectedDay = CalendarUtil.thisDay();
  get selectedYear => _selectedYear;
  get selectedMonth => _selectedMonth;
  get selectedDay => _selectedDay;
  get writeList => _selectedDay; // TODO: writeList를 선택한 날의 writeList로 바꾸기

  DiaryController d = Get.find();

  String get selectedDate =>
      DateConverter.dateToString(_selectedYear, _selectedMonth, _selectedDay);

  void selectDay(int day) {
    _selectedDay = day;
    d.findDataByDate(selectedDate);
    printLog('selectedDay : $_selectedDay');
    update();
  }

  bool isSelected(int day) {
    return day == _selectedDay;
  }
}
