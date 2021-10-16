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
            Get.back();
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
            const TextWidget.title(text: 'OpenSource Information'),
            _largeGap,
            /* sample Library*/
            TextWidget.header(text: 'Tomorrow Diary Information'),
            _smallGap,
            InkWell(
              child: const TextWidget.body(
                  text:
                      'Github :https://github.com/osamhack2021/app_TomorrowDiary_TomorrowDiary'),
              onTap: () async {
                await launch(
                  'https://github.com/osamhack2021/app_TomorrowDiary_TomorrowDiary',
                  forceWebView: false,
                  forceSafariVC: false,
                );
              },
            ),
            _smallGap,
            TextWidget.body(
                text:
                    '일기를 쓰면 좋다는 사실은 누구나 알고 있다. 하지만 일기를 쓰는 과정은 항상 귀찮고 지루하다. 불편함을 감수하고 일기를 써보면 어제와 비슷하게 완성된 일기에 회의감을 느끼기 마련이다. 이런 귀찮고 지루한 과정을 줄일 수 있는 방법을 찾다가 문득 이런 생각이 들었다. "항상 오늘 있었던 일만 일기로 써야 할까?", "내일의 계획을 일기로 써보면 어떨까?"'),
            _largeGap,
            /* another Library*/
            const TextWidget.title(text: 'Developer'),
            _largeGap,
            InkWell(
              child: const TextWidget.body(
                  text:
                      'TeamLeader : Jeong Jongin\nGithub : https://github.com/chongin12'),
              onTap: () async {
                await launch(
                  'https://github.com/chongin12',
                  forceWebView: false,
                  forceSafariVC: false,
                );
              },
            ),
            _smallGap,
            InkWell(
              child: const TextWidget.body(
                  text:
                      'TeamMember : Kim BeomJoon\nGithub : https://github.com/sn0wd3er'),
              onTap: () async {
                await launch(
                  'https://github.com/sn0wd3er',
                  forceWebView: false,
                  forceSafariVC: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//출처 livingstills.tumblr.com