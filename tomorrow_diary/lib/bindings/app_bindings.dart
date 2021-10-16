import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/services/services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    // 의존성 주입 하는곳
    await Get.putAsync(() => FirebaseService().init());
    Get.put(UserController());
    Get.put(AchievementController());
    Get.put(GalleryController());
  }
}
