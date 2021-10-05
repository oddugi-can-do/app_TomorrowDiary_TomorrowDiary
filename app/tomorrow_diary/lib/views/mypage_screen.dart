import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/achievement_controller.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class MyPageScreen extends StatelessWidget {
  static const pageId = '/mypage';

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find();
    AchievementController a = Get.find();
    const Widget _smallGap = const SizedBox.square(dimension: TdSize.s);
    const Widget _largeGap = const SizedBox.square(dimension: TdSize.l);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TdColor.black,
        shadowColor: null,
        leading: IconButton(
          onPressed: () {
            Get.off(() => HomeScreen());
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      backgroundColor: TdColor.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
              vertical: TdSize.xl, horizontal: TdSize.xxl),
          children: [
            TextWidget.header(text: '사용자 정보'),
            _largeGap,
            Row(
              children: [
                TextWidget.body(text: '이메일 : '),
                _smallGap,
                TextWidget.body(
                  text: u.principal.value.email ?? "error : no email",
                ),
              ],
            ),
            _largeGap,
            Row(
              children: [
                TextWidget.body(text: '사용자 이름 : '),
                _smallGap,
                TextWidget.body(
                  text: u.principal.value.uid ?? "error : no username",
                ),
              ],
            ),
            _largeGap,
            _largeGap,
            TextWidget.header(text: '업적'),
            ...a.achievements.value.achievements.map(
              (e) => Column(
                children: [
                  _smallGap,
                  AchievementWidget(title: e.title, description: e.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
