import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/services/services.dart';

class RootScreenBindings extends Bindings {
  @override
  void dependencies() {
    // await Get.putAsync(() => FirebaseService().init());
    Get.put<UserController>(UserController(), permanent: true);
  }
}
