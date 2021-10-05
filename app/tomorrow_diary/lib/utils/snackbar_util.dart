import 'package:get/get.dart';

void snackBar({required String? msg}) {
  Future.delayed(Duration(seconds: 1)).then((_) {
    Get.snackbar("Error", msg!, snackPosition: SnackPosition.BOTTOM);
  });
}
