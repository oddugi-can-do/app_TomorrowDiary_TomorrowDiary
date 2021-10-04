import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/achievement_controller.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class MyPageScreen extends StatelessWidget {
  static const pageId = '/mypage';

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find();
    AchievementController a = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextWidget.header(text: '사용자 정보'),
            Row(
              children: [
                TextWidget.body(text: '이메일'),
                TextWidget.body(
                  text: u.principal.value.email ?? "error : no email",
                ),
              ],
            ),
            Row(
              children: [
                TextWidget.body(text: '사용자 이름'),
                TextWidget.body(
                  text: u.principal.value.uid ?? "error : no username",
                ),
              ],
            ),
            TextWidget.header(text: '업적'),
            ...a.achievements.value.achievements.map(
              (e) =>
                  AchievementWidget(title: e.title, description: e.description),
            ),
          ],
        ),
      ),
    );
  }
}
