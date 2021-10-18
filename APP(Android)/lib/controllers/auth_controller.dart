import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<bool> login(
      String email, String password, BuildContext context) async {
    _showDialog(context);
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
      // Navigator.pop(context);
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }

  Future<bool> join(String email, String password, String username,
      BuildContext context) async {
    _showDialog(context);
    UserModel principal = await _userRepo.join(email, password, username);
    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.email;
      await storage.write(
        key: "login",
        value: "id " + email + " " + "password " + password,
      );
      // Navigator.pop(context);
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }

  Future<void> googleLogin(BuildContext context) async {
    _showDialog(context);
    UserModel? principal = await _userRepo.googleSiginIn();
    if (principal!.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.google;
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
    } else {
      Navigator.pop(context);
      snackBar(msg: "구글 로그인을 실패하였습니다.");
    }
  }

  Future<void> facebookLogin(BuildContext context) async {
    _showDialog(context);
    UserModel? principal = await _userRepo.facebookSiginIn();
    if (principal != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      this.signMethod.value = SignMethod.facebook;
      Get.offAll(HomeScreen(), binding: HomeScreenBindings());
    } else {
      Navigator.pop(context);
      snackBar(msg: "페이스북 로그인을 실패하였습니다.");
      return;
    }
  }

  Future<void> checkPermit(String uid) async{
    UserModel principal =await  _userRepo.checkPermission(uid);
    this.principal.value.isAdmin = principal.isAdmin;
  }


  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false, 
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 100000), () {
          Navigator.pop(context);
        });

        return AlertDialog(
          backgroundColor: TdColor.brown,
          title: const Text("로그인 중입니다. 잠시만 기다려주십시오",
              style: TextStyle(color: Colors.white)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: 100),
                SizedBox(height: 30),
                Center(
                    child: SizedBox(
                  child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 5.0),
                  height: 25.0,
                  width: 25.0,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum SignMethod { google, facebook, email }
