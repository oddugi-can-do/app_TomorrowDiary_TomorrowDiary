// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:tomorrow_diary/controllers/user_network_controller.dart';
// import 'package:tomorrow_diary/utils/utils.dart';

import 'package:get/get.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/models/user/user_repo.dart';
import 'package:tomorrow_diary/views/views.dart';

class UserController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final RxBool isLogin = false.obs;
  final principal = UserModel().obs;

  Future<void> logout() async {
    await _userRepo.logout();
    this.principal.value = UserModel(); // 유저 값 초기화
    this.isLogin.value = false;
    Get.offAll(AuthScreen());
  }

  Future<bool> login(String email, String password) async {
    UserModel? principal =
        await _userRepo.login(email: email, password: password);

    if (principal!.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      print(principal);
      Get.to(HomeScreen());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(String email, String password) async {
    UserModel principal = await _userRepo.join(email, password);
    print(principal);
    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      Get.to(HomeScreen());
      return true;
    } else {
      return false;
    }
  }
}
