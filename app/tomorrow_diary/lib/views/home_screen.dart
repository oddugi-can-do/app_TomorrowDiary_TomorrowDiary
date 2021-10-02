import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
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
        backgroundColor: TdColor.black,
        appBar: appBar(),
        body: ListView(
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
                            _buildTyDiaryModal(context);
                          },
                        );
                      } else if (controller.selectedDay ==
                          CalendarUtil().thisDay()) {
                        return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray,
                            () {
                          _buildTyDiaryModal(context);
                        });
                      } else {
                        return Container();
                      }
                    }
                    //아무것도 선택 안 했을 때 default
                    return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightGray,
                        () {
                      _buildTyDiaryModal(context);
                    });
                  },
                ),
                GetBuilder<CalendarController>(
                  builder: (controller) {
                    return controller.selectedDay ==
                            CalendarUtil().thisDay() + 1
                        ? _buildServeWidget('내일의 일기 쓰기', TdColor.lightGray, () {
                            _buildTmrDiaryModal(context);
                          })
                        : Container();
                  },
                ),
                GetBuilder<CalendarController>(
                  builder: (controller) {
                    return _buildServeWidget('To-Do List', TdColor.lightGray,
                        () {
                      _buildTodoListModal(context);
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }

  Future<dynamic> _buildTmrDiaryModal(BuildContext context) {
    List<Widget> listItems = [
      SingleLineForm(hint: '내일의 일기 제목'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일 있어야 할 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '내일 있어야 할 일을 적어주세요'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일 기대하고 있는 일'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(text: 'example wish1'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(text: 'example wish2'),
      const SizedBox(height: TdSize.s),
      const WishListForm(hint: 'wish list gogo'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일의 기분'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.'),
      const SizedBox(height: TdSize.m),
      SubmitButtonWidget(text: '작성 완료'),
    ];
    return _barModalWithListItems(context, listItems, '내일의 일기');
  }

  Future<dynamic> _buildTyDiaryModal(BuildContext context) {
    List<Widget> listItems = [
      SingleLineForm(hint: '오늘의 일기 제목'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘 있었던 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '위시리스트'),
      const SizedBox(height: TdSize.s),
      WishListWidget(text: 'example wish1'),
      const SizedBox(height: TdSize.s),
      WishListWidget(text: 'example wish2'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '예상치 못한 일이 있었나요?'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘의 진짜 기분'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.'),
      const SizedBox(height: TdSize.l),
      SubmitButtonWidget(text: '작성 완료'),
    ];
    return _barModalWithListItems(context, listItems, '오늘의 일기');
  }

  Future<dynamic> _buildTodoListModal(BuildContext context) {
    List<Widget> listItems = [
      const SizedBox(height: TdSize.l),
      TodoListWidget(todo: 'todo example 1'),
      const SizedBox(height: TdSize.s),
      TodoListWidget(
          todo: 'todo example 2', timeStart: '09:30', timeEnd: '10:30'),
      const SizedBox(height: TdSize.s),
      TodoListForm(
        hint: '해야 할 일',
        onSubmitted: () {},
      ),
    ];
    return _barModalWithListItems(context, listItems, 'To-do List');
  }

  Future<dynamic> _barModalWithListItems(
      BuildContext context, List<Widget> listItems, String title) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: NestedScrollView(
          controller: ScrollController(),
          physics: const ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool isInnerBoxScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                        child: TextWidget.body(text: title),
                      ),
                    ),
                  )
                ]),
              ),
            ];
          },
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: TdSize.m, horizontal: TdSize.xl),
            physics: AlwaysScrollableScrollPhysics(),
            // 이 physics를 추가 안하면 listview로 화면이 가득 차지 않을 때 버그가 남.
            controller: PrimaryScrollController.of(context),
            itemBuilder: (context, index) => listItems[index],
            itemCount: listItems.length,
          ),
        ),
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
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.calendar_today_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
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
