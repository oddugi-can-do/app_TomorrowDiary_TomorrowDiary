import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/home_screen_bindings.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class LoginScreen extends StatelessWidget {
  static const pageId = '/login';

  final UserController u = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: Text('homescreen'),
        onPressed: () async {
          int result = await u.login("test2@test.com", "123123");
          if (result == 1) {
            Get.to(() => HomeScreen(), binding: HomeScreenBindings());
          } else {
            Get.snackbar("로그인 시도", "로그인 실패");
          }
        },
      ),
      ElevatedButton(
        child: Text('join'),
        onPressed: () async {
          int result = await u.join("test2@test.com", "123123", "test2");
          if (result == 1) {
            Get.to(() => HomeScreen());
          } else {
            Get.snackbar("로그인 시도", "로그인 실패");
          }
        },
      ),
    ]);
  }
}
