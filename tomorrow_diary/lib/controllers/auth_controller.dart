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

  Future<void> logout() async {
    switch(this.signMethod.value) {
      case SignMethod.email :
        await _userRepo.logout();
        break;
      case SignMethod.google:
        GoogleSignIn().signOut();
        // TODO: Handle this case.
        break;
      case SignMethod.facebook:
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

    if (principal!.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.email;
      Get.to(HomeScreen(), binding: HomeScreenBindings());
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
      Get.to(HomeScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      return false;
    }
  }

  Future<void> googleLogin() async {
    UserModel principal = await _userRepo.googleSiginIn(); 
    if(principal!= null) {
          snackBar(msg: "${principal.email} , ${principal.username} , ${principal.uid}");
          this.isLogin.value = true;
          this.principal.value = principal;
          this.signMethod.value = SignMethod.google;
          Get.to(HomeScreen(), binding: HomeScreenBindings());
    }
   
  }
}

enum SignMethod {
  google,facebook,email
}