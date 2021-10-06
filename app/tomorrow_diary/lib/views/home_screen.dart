import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/controllers/user_network_controller.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/views/select_year_and_month_screen.dart';
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
  int selectedYear = 0;
  int selectedMonth = 0;

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

  @override
  void initState() {
    super.initState();
    DiaryController d = Get.find();
    CalendarController c = Get.find();
    d.findDataByDate(c.selectedDate);
    selectedYear = c.selectedYear;
    selectedMonth = c.selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _key,
        endDrawer: ClipPath(child: DrawerSideMenu()
        ),
        backgroundColor: TdColor.black,
        appBar: appBar(),
        body: _buildHomeScreen(context));
  }

  Widget _buildHomeScreen(BuildContext context) { //ListView
    CalendarController c = Get.find();

    return  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/tomorrow2.gif'), fit: BoxFit.cover),
        ),
        child:ListView(
      key: GlobalKey(),
      children: [
        CalendarWidget(year: selectedYear, month: selectedMonth),
        const Padding(
          padding: EdgeInsets.only(left: 13),
          child: TextWidget.body(text: '일기 쓰기'),
        ),
        GetBuilder<CalendarController>(builder: (controller) {
          TimePoint timePoint =
              CalendarUtil.decidePastPresentFutureWithDate(c.selectedDate);
          return Column(
            children: [
              _buildTyServeWidget(timePoint),
              _buildTmrServeWidget(timePoint),
              _buildTodoServeWidget(timePoint),
            ],
          );
        })
      ],
        )
    );
  }

  Widget _buildTyServeWidget(TimePoint timePoint) {
    switch (timePoint) {
      case TimePoint.past:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: '오늘의 일기 보기',
            color: TdColor.lightRed,
            //TODO: ServeWidget 안에서 color 판단하기!
            onPressed: () {
              ModalUtil.barModalWithTyDiaryScreen(context);
            },
          ),
        );
      case TimePoint.present:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: '오늘의 일기 쓰기',
            color: TdColor.lightGray,
            onPressed: () {
              ModalUtil.barModalWithTyDiaryScreen(context);
            },
          ),
        );
      case TimePoint.future:
        return Container();
      case TimePoint.tomorrow:
        return Container();
    }
  }

  Widget _buildTmrServeWidget(TimePoint timePoint) {
    switch (timePoint) {
      case TimePoint.past:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: '내일의 일기 보기',
            color: TdColor.lightBlue,
            onPressed: () {
              ModalUtil.barModalWithTmrDiaryScreen(context);
            },
          ),
        );
      case TimePoint.present:
        return Container();
      case TimePoint.tomorrow:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: '내일의 일기 쓰기',
            color: TdColor.lightGray,
            onPressed: () {
              ModalUtil.barModalWithTmrDiaryScreen(context);
            },
          ),
        );
      case TimePoint.future:
        return Container();
    }
  }

  Widget _buildTodoServeWidget(TimePoint timePoint) {
    switch (timePoint) {
      case TimePoint.past:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: 'To-do List 보기',
            color: TdColor.lightGreen,
            onPressed: () {
              ModalUtil.barModalWithTodoListScreen(context);
            },
          ),
        );
      case TimePoint.present:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: 'To-do List 보기',
            color: TdColor.lightGray,
            onPressed: () {
              ModalUtil.barModalWithTodoListScreen(context);
            },
          ),
        );
      case TimePoint.tomorrow:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: 'To-do List 보기',
            color: TdColor.lightGray,
            onPressed: () {
              ModalUtil.barModalWithTodoListScreen(context);
            },
          ),
        );
      case TimePoint.future:
        return Padding(
          padding: const EdgeInsets.all(TdSize.s),
          child: ServeWidget(
            text: 'To-do List 보기',
            color: TdColor.lightGray,
            onPressed: () {
              ModalUtil.barModalWithTodoListScreen(context);
            },
          ),
        );
    }
  }

  AppBar appBar() {
    DateTime _selectedTime;
    return AppBar(
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
                    onChanged: _yearAndMonthChanged),
                  ),
            );
          },
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
      title: TextWidget.header(text: '$selectedYear년 $selectedMonth월'),
    );
  }
}
