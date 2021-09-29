import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<CalendarController>(() => CalendarController(), fenix: false);
  }
}
