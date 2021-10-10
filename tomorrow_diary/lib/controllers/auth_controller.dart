import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/domain/user/user_repository.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/views/splash_screen.dart';
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
      Get.to(SplashScreen(), binding: HomeScreenBindings());
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
      Get.to(SplashScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> googleLogin() async {
    UserCredential user = await _userRepo.googleSiginIn();
    print(user);
    if (user.user!.uid != null) {
      Get.to(HomeScreen(), binding: HomeScreenBindings());

      return true;
    } else {
      return false;
    }
  }
}
