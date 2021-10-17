import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DiaryController());
    Get.put(CalendarController());
    Get.put(AchievementController());
    Get.put(UserController());
    // Get.lazyPut<CalendarController>(() => CalendarController(), fenix: false);
  }
}
