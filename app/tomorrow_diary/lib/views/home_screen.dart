import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    Get.put(DiaryController());
    Get.put(CalendarController());
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
    UserController u = Get.find();
    DiaryController d = Get.find();
    CalendarController c = Get.find();
    return ListView(
      children: [
        _buildCalendar(),
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
                  // TodoListScreen(todoListData: d.allData.value.todoList)
                  //     .buildTodoListModal(context);
                });
              },
            ),
          ],
        )
      ],
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
          icon: Icon(Icons.menu_rounded),
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

  Widget _buildCalendar() {
    CalendarController c = Get.find();
    List<List<int>> _daysForWeek =
        CalendarUtil.daysForWeek(c.selectedYear, c.selectedMonth);
    printLog(_daysForWeek);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TdSize.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            7,
            (i) => Column(
              children: [
                TextWidget.hint(text: CalendarUtil().week[i]),
                ...List.generate(
                  _daysForWeek[i].length,
                  (j) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: TdSize.s),
                      child: _getCalendarDayButtonWidget(_daysForWeek[i][j]),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getCalendarDayButtonWidget(int day) {
    CalendarController c = Get.find();
    if (day == -1) {
      return CalendarDayButtonWidget.disabled();
    } else if (CalendarUtil.isIncludeToday(c.selectedYear, c.selectedMonth) &&
        day == CalendarUtil.thisDay()) {
      return CalendarDayButtonWidget.highlighted(day: day);
    } else {
      return CalendarDayButtonWidget(day: day);
    }
  }
}
