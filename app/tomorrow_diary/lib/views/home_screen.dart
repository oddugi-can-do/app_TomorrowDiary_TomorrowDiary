import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const pageId = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with PrintLogMixin {
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
                      if (controller.selectedDay < 15) {
                        return _buildServeWidget('오늘의 일기 쓰기', TdColor.lightRed);
                      } else if (controller.selectedDay == 15) {
                        return _buildServeWidget(
                            '오늘의 일기 쓰기', TdColor.lightGray);
                      }
                    }
                    return Container();
                  },
                ),
                GetBuilder<CalendarController>(
                  builder: (controller) {
                    return controller.selectedDay == 16
                        ? _buildServeWidget('내일의 일기 쓰기', TdColor.lightGray)
                        : Container();
                  },
                ),
                GetBuilder<CalendarController>(
                  builder: (controller) {
                    return controller.selectedDay != 0
                        ? _buildServeWidget('To-Do List', TdColor.lightGray)
                        : Container();
                  },
                ),
              ],
            )
          ],
        ));
  }

  Padding _buildServeWidget(String text, Color color) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: ServeWidget(
        text: text,
        color: color,
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
      title: const TextWidget.header(text: '2021년 09월'),
    );
  }

  Widget _buildCalendar(CalendarController controller) {
    int _shift = 3;
    int _lastDay = 30;

    List<String> _week = ['일', '월', '화', '수', '목', '금', '토'];
    List<int> _day = List.generate(_lastDay, (index) => index + 1);
    List<List<int>> _dayForWeek = List.generate(
        7,
        (i) => List.generate(
            (_shift + _lastDay + 6) ~/ 7,
            (j) => (i + j * 7) < _shift || (i + j * 7) >= _shift + _lastDay
                ? -1
                : _day[i + j * 7 - _shift]));
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
                  child: TextWidget.hint(text: _week[i]),
                ),
                ...List.generate(
                  _dayForWeek[i].length,
                  (j) => _dayForWeek[i][j] == -1
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: TdSize.m),
                          child: CalendarDayButtonWidget.disabled(
                            controller: controller,
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: TdSize.m),
                          child: CalendarDayButtonWidget(
                            day: _dayForWeek[i][j],
                            controller: controller,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
