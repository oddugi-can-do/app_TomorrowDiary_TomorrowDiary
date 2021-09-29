import 'package:get/get.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class CalendarController extends GetxController with PrintLogMixin {
  int _selectedYear = 0;
  int _selectedMonth = 0;
  int _selectedDay = 0;
  get selectedDay => _selectedDay;
  get writeList => _selectedDay; // TODO: writeList를 선택한 날의 writeList로 바꾸기

  void selectDay(int day) {
    _selectedDay = day;
    printLog('selectedDay : $_selectedDay');
    update();
  }

  bool isSelected(int day) {
    return day == _selectedDay;
  }
}
