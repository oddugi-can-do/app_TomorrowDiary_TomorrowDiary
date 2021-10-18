import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/select_year_and_month_screen.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class MyPageScreen extends StatefulWidget {
  static const pageId = '/mypage';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  Achievements myAchievements = Achievements();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final Widget _smallGap = const SizedBox.square(dimension: TdSize.s);
  final Widget _largeGap = const SizedBox.square(dimension: TdSize.l);
  @override
  void initState() {
    super.initState();
    AchievementController a = Get.find();
    a.findData().then((value) => myAchievements = value);
  }

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find();
    return Scaffold(
      key: _key,
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
            const TextWidget.header(text: '사용자 정보'),
            _largeGap,
            Row(
              children: [
                const TextWidget.body(text: '이메일 : '),
                _smallGap,
                TextWidget.body(
                  text: u.principal.value.email ?? "error : no email",
                ),
              ],
            ),
            _largeGap,

            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       AchievementController a = Get.find();
            //       a.setDataWithAchievementList(AchievementType.welcome);
            //     });
            //   },
            //   child: const TextWidget.body(text: 'test : 업적 추가 : welcome!'),
            // ),
            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       AchievementController a = Get.find();
            //       a.setDataWithAchievementList(AchievementType.openTmrDiary);
            //     });
            //   },
            //   child:
            //       const TextWidget.body(text: 'test : 업적 추가 : openTmrDiary!'),
            // ),
            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       AchievementController a = Get.find();
            //       a.setDataWithAchievementList(AchievementType.army);
            //     });
            //   },
            //   child: const TextWidget.body(text: 'test : 업적 추가 : army'),
            // ),
            // _largeGap,
            Row(
              children: [
                const TextWidget.body(text: '사용자 이름 : '),
                _smallGap,
                TextWidget.body(
                  text: u.principal.value.username ?? '',
                ),
              ],
            ),
            _largeGap,
            _largeGap,
            ElevatedButton(
              onPressed: () {
                int year = CalendarUtil.thisYear(),
                    month = CalendarUtil.thisMonth();
                showModalBottomSheet(
                  backgroundColor: Colors.black87,
                  context: context,
                  builder: (BuildContext context) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: SelectYearAndMonthScreen(
                      initialYear: year,
                      initialMonth: month,
                      onSubmitted: _yearAndMonthChanged,
                      onCanceled: () {},
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(TdSize.l),
                child: TextWidget.header(text: '분석하기'),
              ),
              style: ElevatedButton.styleFrom(primary: TdColor.brown),
            ),
            _largeGap,
            _largeGap,
            const TextWidget.header(text: '업적'),
            Obx(() => _buildAchievements()),
          ],
        ),
      ),
    );
  }

  void _yearAndMonthChanged(int _year, int _month) {
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Get.to(AnalysisScreen(selectedYear: _year, selectedMonth: _month)));
  }

  Widget _buildAchievements() {
    AchievementController a = Get.find();
    if ((a.achievements.value.achievements ?? []).isEmpty) {
      return Column(
        children: [
          _smallGap,
          const TextWidget.body(text: '아직 업적이 없습니다'),
        ],
      );
    } else {
      List<Widget> temp = [];
      for (var element in myAchievements.achievements ?? []) {
        temp.add(_smallGap);
        temp.add(AchievementWidget(achievement: element));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: temp,
      );
    }
  }
}
