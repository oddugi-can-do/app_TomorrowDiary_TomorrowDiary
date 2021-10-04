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
  int selectedYear = 0;
  int selectedMonth = 0;
    GlobalKey<ScaffoldState> _key = GlobalKey();

  List<TempTodoModel> todoListData = [
    // 나중에 todo list 모델로 변환!
    TempTodoModel(todo: '투두리스트 시간없는거'),
    TempTodoModel.withString("09:30", "10:30", todo: '투두리스트 시간있는거'),
  ];

  List<String> wishListData = [
    // 나중에 wish list 모델로 변환!
    "위시리스트 1",
    "위시리스트 2",
  ];

  @override
  void initState() {
    super.initState();

    selectedYear = CalendarUtil().thisYear();
    selectedMonth = CalendarUtil().thisMonth();
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarController());
    return Scaffold(
        key: _key,
        endDrawer: DrawerSideMenu(),
        backgroundColor: TdColor.black,
        appBar: appBar(),
        body: _buildHomeScreen(controller, context));
  }

  ListView _buildHomeScreen(
      CalendarController controller, BuildContext context) {
    return ListView(
      children: [
        _buildCalendar(controller),
        const Padding(
          padding: EdgeInsets.only(left: 13),
          child: TextWidget.body(text: '일기 쓰기'),
        ),
        Column(
          children: [
            GetBuilder<CalendarController>(
              builder: (controller) {
                if (controller.selectedDay != 0) {
                  if (controller.selectedDay < CalendarUtil().thisDay()) {
                    return _buildServeWidget(
                      '오늘의 일기 쓰기',
                      TdColor.lightRed,
                      () {
                        TyDiaryScreen(wishListData: wishListData)
                            .buildTyDiaryModal(context);
                      },
                    );
                  } else if (controller.selectedDay ==
                      CalendarUtil().thisDay()) {
                    return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray,
                        () {
                      TyDiaryScreen(wishListData: wishListData)
                          .buildTyDiaryModal(context);
                    });
                  } else {
                    return Container();
                  }
                }
                //아무것도 선택 안 했을 때 default
                return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray, () {
                  TyDiaryScreen(wishListData: wishListData)
                      .buildTyDiaryModal(context);
                });
              },
            ),
            GetBuilder<CalendarController>(
              builder: (controller) {
                return controller.selectedDay == CalendarUtil().thisDay() + 1
                    ? _buildServeWidget('내일의 일기 쓰기', TdColor.lightGray, () {
                        // _buildTmrDiaryModal(context, wishListData);
                        TmrDiaryScreen(wishListData: wishListData)
                            .buildTmrDiaryModal(context);
                      })
                    : Container();
              },
            ),
            GetBuilder<CalendarController>(
              builder: (controller) {
                return _buildServeWidget('To-Do List', TdColor.lightGray, () {
                  TodoListScreen(todoListData: todoListData)
                      .buildTodoListModal(context);
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
    return AppBar(
      actions: [
        
        IconButton(
          alignment: Alignment.center,
          onPressed: () {
          },
          icon: const Icon(Icons.calendar_today_rounded),
        ),
        IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: (){
              _key.currentState!.openEndDrawer();
            },
          ),
      ],
      actionsIconTheme: const IconThemeData(
        color: TdColor.white,
      ),
      backgroundColor: Colors.transparent,
      shadowColor: null,
      title: TextWidget.header(text: '$selectedYear년 $selectedMonth월'),
    );
  }

  Widget _buildCalendar(CalendarController controller) {
    List<List<int>> _daysForWeek =
        CalendarUtil().daysForWeek(selectedYear, selectedMonth);
    printLog(_daysForWeek);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            7,
            (i) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                  child: TextWidget.hint(text: CalendarUtil().week[i]),
                ),
                ...List.generate(
                  _daysForWeek[i].length,
                  (j) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                      child: _getCalendarDayButtonWidget(
                          _daysForWeek[i][j], controller),
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

  Widget _getCalendarDayButtonWidget(int day, CalendarController controller) {
    if (day == -1) {
      return CalendarDayButtonWidget.disabled(
        controller: controller,
      );
    } else if (CalendarUtil().isIncludeToday(selectedYear, selectedMonth) &&
        day == CalendarUtil().thisDay()) {
      return CalendarDayButtonWidget.highlighted(
        day: day,
        controller: controller,
      );
    } else {
      return CalendarDayButtonWidget(
        day: day,
        controller: controller,
      );
    }
  }
}


