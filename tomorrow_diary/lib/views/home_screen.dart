import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/screen_size.dart';
import 'package:tomorrow_diary/views/select_year_and_month_screen.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

enum MenuStatus { opened, closed }

class HomeScreen extends StatefulWidget {
  static const pageId = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  AnimationController? _animationMenuController;
  int selectedYear = 0;
  int selectedMonth = 0;
  MenuStatus _menuStatus = MenuStatus.closed;
  double menuXpos = screenSize!.width;
  double menuWidth = screenSize!.width * 2 / 3;
  double bodyXpos = 0;
  @override
  void initState() {
    super.initState();
    DiaryController d = Get.find();
    CalendarController c = Get.find();
    Get.put(GalleryController());
    _animationMenuController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    d.findDataByDate(c.selectedDate);
    selectedYear = c.selectedYear;
    selectedMonth = c.selectedMonth;
  }

  @override
  void dispose() {
    _animationMenuController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      backgroundColor: TdColor.black,
      body: _buildAnimatedHomeScreen(context),
    );
  }

  Stack _buildAnimatedHomeScreen(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          child: _buildHomeScreen(context, () {
            setState(() {
              _menuStatus = (_menuStatus == MenuStatus.closed)
                  ? MenuStatus.opened
                  : MenuStatus.closed;
              switch (_menuStatus) {
                case MenuStatus.opened:
                  bodyXpos = -menuWidth;
                  menuXpos = screenSize!.width - menuWidth;
                  break;
                case MenuStatus.closed:
                  bodyXpos = 0;
                  menuXpos = screenSize!.width;
                  break;
              }
            });
          }),
          duration: _menuStatus == MenuStatus.opened
              ? Duration(milliseconds: 1000)
              : Duration(milliseconds: 2000),
          transform: Matrix4.translationValues(bodyXpos, 0, 0),
          curve: Curves.fastOutSlowIn,
        ),
        AnimatedContainer(
          child: DrawerSideMenu(menuWidth),
          duration: _menuStatus == MenuStatus.opened
              ? Duration(milliseconds: 2000)
              : Duration(milliseconds: 2000),
          transform: Matrix4.translationValues(menuXpos, 0, 0),
          curve: Curves.fastOutSlowIn,
        ),
      ],
    );
  }

  Widget _buildHomeScreen(BuildContext context, Function changeMenuStatus) {
    CalendarController c = Get.find();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/tomorrow2.gif'), fit: BoxFit.cover),
      ),
      child: Obx(
        () {
          TimePoint timePoint =
              CalendarUtil.decidePastPresentFutureWithDate(c.selectedDate);
          return ListView(
            key: GlobalKey(),
            children: [
              appBar(changeMenuStatus),
              CalendarWidget(year: selectedYear, month: selectedMonth),
              const Padding(
                padding: EdgeInsets.only(left: 13),
                child: TextWidget.body(text: '일기 쓰기'),
              ),
              Column(
                key: GlobalKey(),
                children: [
                  _buildTyServeWidget(timePoint),
                  _buildTmrServeWidget(timePoint),
                  _buildTodoServeWidget(timePoint),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTyServeWidget(TimePoint timePoint) {
    DiaryController d = Get.find();
    switch (timePoint) {
      case TimePoint.past:
        if (d.allData.value.tyDiary == null ||
            d.allData.value.tyDiary!.isEmpty()) {
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '오늘의 일기 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTyDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        }
      case TimePoint.present:
        if (d.allData.value.tyDiary == null ||
            d.allData.value.tyDiary!.isEmpty()) {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '오늘의 일기 쓰기',
              color: TdColor.lightGray,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTyDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '오늘의 일기 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTyDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        }
      case TimePoint.future:
        return Container();
      case TimePoint.tomorrow:
        return Container();
    }
  }

  Widget _buildTmrServeWidget(TimePoint timePoint) {
    DiaryController d = Get.find();
    switch (timePoint) {
      case TimePoint.past:
        if (d.allData.value.tmrDiary == null ||
            d.allData.value.tmrDiary!.isEmpty()) {
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '내일의 일기 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTmrDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        }
      case TimePoint.present:
        return Container();
      case TimePoint.tomorrow:
        if (d.allData.value.tmrDiary == null ||
            d.allData.value.tmrDiary!.isEmpty()) {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '내일의 일기 쓰기',
              color: TdColor.lightGray,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTmrDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: '내일의 일기 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTmrDiaryScreen(context, timePoint);
                });
              },
            ),
          );
        }
      case TimePoint.future:
        return Container();
    }
  }

  Widget _buildTodoServeWidget(TimePoint timePoint) {
    DiaryController d = Get.find();
    switch (timePoint) {
      case TimePoint.past:
        if (d.allData.value.todoList == null ||
            d.allData.value.todoList!.isEmpty) {
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: 'To-do List 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTodoListScreen(context);
                });
              },
            ),
          );
        }
      case TimePoint.present:
      case TimePoint.tomorrow:
      case TimePoint.future:
        if (d.allData.value.todoList == null ||
            d.allData.value.todoList!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: 'To-do List 쓰기',
              color: TdColor.lightGray,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTodoListScreen(context);
                });
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(TdSize.s),
            child: ServeWidget(
              text: 'To-do List 보기',
              color: TdColor.brown,
              onPressed: () {
                setState(() {
                  ModalUtil.barModalWithTodoListScreen(context);
                });
              },
            ),
          );
        }
    }
  }

  AppBar appBar(Function changeMenuStatus) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          alignment: Alignment.center,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.black87,
              context: context,
              builder: (BuildContext context) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: SelectYearAndMonthScreen(
                  initialYear: selectedYear,
                  initialMonth: selectedMonth,
                  onSubmitted: _yearAndMonthChanged,
                  onCanceled: () {},
                ),
              ),
            );
          },
          icon: const Icon(Icons.calendar_today_rounded),
        ),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationMenuController!,
          ),
          onPressed: () {
            changeMenuStatus();
            _animationMenuController!.status == AnimationStatus.completed
                ? _animationMenuController!.reverse()
                : _animationMenuController!.forward();
            // _key.currentState!.openEndDrawer();
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

  void _yearAndMonthChanged(int _year, int _month) {
    CalendarController c = Get.find();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => setState(
        () {
          selectedYear = _year;
          selectedMonth = _month;
          c.selectYearAndMonth(selectedYear, selectedMonth);
        },
      ),
    );
  }
}
