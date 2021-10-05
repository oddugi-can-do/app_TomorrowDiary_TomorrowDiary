import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/achievement_controller.dart';

class MypageScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AchievementController());
  }
}
