import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class CalendarWidget extends StatefulWidget {
  final int year;
  final int month;
  const CalendarWidget({Key? key, required this.year, required this.month})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<int> _dayListForMonth = [];
  int year = 0;
  int month = 0;

  @override
  void initState() {
    super.initState();
    year = widget.year;
    month = widget.month;
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize = MediaQuery.of(context).size.width * 0.035;
    _dayListForMonth = CalendarUtil.dayListForMonth(year, month);
    return Padding(
      padding: const EdgeInsets.all(TdSize.s),
      child: GridView.builder(
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        key: GlobalKey(),
        itemCount: 7 + _dayListForMonth.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 2, //수평 Padding
          crossAxisSpacing: 2, //수직 Padding
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index < 7) {
            return Center(
              child: TextWidget.calendar(
                text: CalendarUtil.week[index],
                fontSize: _fontSize,
                color: TdColor.gray,
              ),
            );
          }
          if (_dayListForMonth[index - 7] == -1) {
            return CalendarDayButtonWidget.disabled();
          } else if (CalendarUtil.isIncludeToday(year, month) &&
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
}
