import 'package:get/state_manager.dart';
import 'package:tomorrow_diary/models/models.dart';

class TodoFormController extends GetxController {
  final _title = ''.obs;
  final _start = 'start'.obs;
  final _end = 'end'.obs;
  final _isTimeEnabled = false.obs;
  String get title => _title.value;
  String get start => _start.value;
  String get end => _end.value;
  bool get isTimeEnabled => _isTimeEnabled.value;
  Todo get todo => Todo(
        todo: title,
        start: start,
        end: end,
        checked: false,
        timeEnabled: isTimeEnabled,
      );

  void setTitle(String value) => _title.value = value;
  void setStart(String value) => _start.value = value;
  void setEnd(String value) => _end.value = value;
  void setIsTimeEnabled(bool value) => _isTimeEnabled.value = value;
  void toggleTimeEnabled() => _isTimeEnabled.value = !_isTimeEnabled.value;
  void resetData() {
    setTitle('');
    setStart('start');
    setEnd('end');
    setIsTimeEnabled(false);
  }
}
