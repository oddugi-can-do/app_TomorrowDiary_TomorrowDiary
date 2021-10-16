import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/domain/user/user_repository.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/views.dart';

class UserController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final RxBool isLogin = false.obs;
  final principal = UserModel().obs;
  final signMethod = SignMethod.email.obs;
  static final storage = new FlutterSecureStorage();

  Future<void> logout() async {
    switch (this.signMethod.value) {
      case SignMethod.email:
        storage.delete(key: "login");
        await _userRepo.logout();
        break;
      case SignMethod.google:
        GoogleSignIn().signOut();
        // TODO: Handle this case.
        break;
      case SignMethod.facebook:
        FacebookAuth.instance.logOut();
        // TODO: Handle this case.
        break;
    }
    this.principal.value = UserModel(); // 유저 값 초기화
    this.isLogin.value = false;
    Get.offAll(AuthScreen());
  }

  Future<bool> login(String email, String password) async {
    UserModel? principal =
        await _userRepo.login(email: email, password: password);

    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.email;
      await storage.write(
        key: "login",
        value: "id " + email + " " + "password " + password,
      );
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(String email, String password, String username) async {
    UserModel principal = await _userRepo.join(email, password, username);
    print(principal);
    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.email;
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      return false;
    }
  }

  Future<void> googleLogin() async {
    UserModel principal = await _userRepo.googleSiginIn();
    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.google;
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
    } else {
      snackBar(msg: "구글 로그인을 실패하였습니다.");
      return;
    }
  }

  Future<void> facebookLogin() async {
    UserModel? principal = await _userRepo.facebookSiginIn();
    if (principal != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.facebook;
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
    } else {
      snackBar(msg: "페이스북 로그인을 실패하였습니다.");
      return;
    }
  }
}

enum SignMethod { google, facebook, email }
