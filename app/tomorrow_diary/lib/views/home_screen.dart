import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/controllers/user_network_controller.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const pageId = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with PrintLogMixin {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  DiaryController d = Get.find();
  CalendarController c = Get.find();

  @override
  void initState() {
    super.initState();
    d.findDataByDate(c.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        endDrawer: DrawerSideMenu(),
        backgroundColor: TdColor.black,
        appBar: appBar(),
        body: _buildHomeScreen(context));
  }

  ListView _buildHomeScreen(BuildContext context) {
    return ListView(
      children: [
        _buildCalendarWithGridView(),
        const Padding(
          padding: EdgeInsets.only(left: 13),
          child: TextWidget.body(text: '일기 쓰기'),
        ),
        Column(
          children: [
            GetBuilder<CalendarController>(
              builder: (controller) {
                if (controller.selectedDay != 0) {
                  if (controller.selectedDay < CalendarUtil.thisDay()) {
                    return _buildServeWidget(
                      '오늘의 일기 보기',
                      TdColor.lightRed,
                      () {
                        ModalUtil.barModalWithTyDiaryScreen(context);
                      },
                    );
                  } else if (controller.selectedDay == CalendarUtil.thisDay()) {
                    return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray,
                        () {
                      ModalUtil.barModalWithTyDiaryScreen(context);
                    });
                  } else {
                    return Container();
                  }
                }
                //아무것도 선택 안 했을 때 default
                return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray, () {
                  ModalUtil.barModalWithTyDiaryScreen(context);
                });
              },
            ),
            GetBuilder<CalendarController>(
              builder: (controller) {
                return controller.selectedDay == CalendarUtil.thisDay() + 1
                    ? _buildServeWidget('내일의 일기 쓰기', TdColor.lightGray, () {
                        ModalUtil.barModalWithTmrDiaryScreen(context);
                      })
                    : Container();
              },
            ),
            GetBuilder<CalendarController>(
              builder: (controller) {
                return _buildServeWidget('To-Do List', TdColor.lightGray, () {
                  ModalUtil.barModalWithTodoListScreen(context);
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCalendarWithGridView() {
    CalendarController c = Get.find();
    List<int> _dayListForMonth =
        CalendarUtil.dayListForMonth(c.selectedYear, c.selectedMonth);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TdSize.s),
      child: GridView.builder(
        itemCount: 7 + _dayListForMonth.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 10, //수평 Padding
          crossAxisSpacing: 10, //수직 Padding
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index < 7) {
            return Center(
              child: TextWidget.hint(text: CalendarUtil.week[index]),
            );
          }
          if (_dayListForMonth[index - 7] == -1) {
            return CalendarDayButtonWidget.disabled();
          } else if (CalendarUtil.isIncludeToday(
                  c.selectedYear, c.selectedMonth) &&
              _dayListForMonth[index - 7] == CalendarUtil.thisDay()) {
            return CalendarDayButtonWidget.highlighted(
                day: _dayListForMonth[index - 7]);
          } else {
            return CalendarDayButtonWidget(day: _dayListForMonth[index - 7]);
          }
        },
      ),
    );
  }

  Padding _buildServeWidget(
      String text, Color color, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(TdSize.s),
      child: ServeWidget(
        text: text,
        color: color,
        onPressed: onPressed,
      ),
    );
  }

  AppBar appBar() {
    CalendarController c = Get.find();
    return AppBar(
      actions: [
        IconButton(
          alignment: Alignment.center,
          onPressed: () {},
          icon: const Icon(Icons.calendar_today_rounded),
        ),
        IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            _key.currentState!.openEndDrawer();
          },
        ),
      ],
      actionsIconTheme: const IconThemeData(
        color: TdColor.white,
      ),
      backgroundColor: Colors.transparent,
      shadowColor: null,
      title: TextWidget.header(text: '${c.selectedYear}년 ${c.selectedMonth}월'),
    );
  }
}
