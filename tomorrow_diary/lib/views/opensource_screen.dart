import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceScreen extends StatelessWidget {
  static const pageId = '/opensource';
  final Widget _smallGap = const SizedBox.square(dimension: TdSize.s);
  final Widget _largeGap = const SizedBox.square(dimension: TdSize.l);

  @override
  Widget build(BuildContext context) {
    String url;
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
            const TextWidget.title(text: '오픈소스 사용 정보'),
            _largeGap,
            /* sample Library*/
            TextWidget.header(text: 'sample Library'),
            _smallGap,
            InkWell(
              child:
                  const TextWidget.body(text: 'https://github.com/chongin12'),
              onTap: () async {
                await launch(
                  'https://github.com/chongin12',
                  forceWebView: false,
                  forceSafariVC: false,
                );
              },
            ),
            _smallGap,
            TextWidget.body(
              text:
                  '설-악산 기슭에서 자라난 우리 열-풍을 식혀버린 영천 대회전 눈-보라 몰아치는 만포선에서 피흘린 자욱마다 영광의 승리 나가-자 싸우-자 승리를 위해 우리들은 불사-신 8사-단 용사',
            ),
            _largeGap,
            /* another Library*/
          ],
        ),
      ),
    );
  }
}
