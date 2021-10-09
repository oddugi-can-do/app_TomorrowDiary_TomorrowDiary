import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class CalendarDayButtonWidget extends StatefulWidget {
  int day = 0;
  String get text => '$day';
  bool isEnabled;
  bool isHighlighted;
  CalendarDayButtonWidget({Key? key, required this.day})
      : isEnabled = true,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.disabled({Key? key})
      : isEnabled = false,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.highlighted({Key? key, required this.day})
      : isEnabled = true,
        isHighlighted = true,
        super(key: key);

  @override
  _CalendarDayButtonWidgetState createState() =>
      _CalendarDayButtonWidgetState();
}

class _CalendarDayButtonWidgetState extends State<CalendarDayButtonWidget> {
  late CalendarController c;
  @override
  void initState() {
    super.initState();
    c = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: widget.isEnabled
          ? widget.isHighlighted
              ? _highlightedContainerBuilder()
              : _enabledContainerBuilder()
          : _disabledContainerBuilder(),
    );
  }

  Widget _enabledContainerBuilder() {
    return c.isSelected(widget.day)
        ? ElevatedButton(
            onPressed: () {
              c.selectDay(widget.day);
            },
            child: _calendarTextWidget(),
            style: selectedButtonStyle(),
          )
        : ElevatedButton(
            onPressed: () {
              c.selectDay(widget.day);
            },
            child: _calendarTextWidget(),
            style: unselectedButtonStyle(),
          );
  }

  Widget _highlightedContainerBuilder() {
    return c.isSelected(widget.day)
        ? ElevatedButton(
            onPressed: () {
              c.selectDay(widget.day);
            },
            child: _calendarTextWidget(),
            style: selectedButtonStyle(),
          )
        : ElevatedButton(
            onPressed: () {
              c.selectDay(widget.day);
            },
            child: _calendarTextWidget(),
            style: highlightedButtonStyle(),
          );
  }

  Widget _disabledContainerBuilder() {
    return Container();
  }

  Widget _calendarTextWidget() {
    return FittedBox(
        fit: BoxFit.contain, child: TextWidget.calendar(text: widget.text));
  }

  ButtonStyle selectedButtonStyle() {
    return ElevatedButton.styleFrom(
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      padding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      shape: CircleBorder(),
      primary: TdColor.blue,
    );
  }

  ButtonStyle unselectedButtonStyle() {
    return ElevatedButton.styleFrom(
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      padding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      shape: CircleBorder(),
      primary: Colors.transparent,
    );
  }

  ButtonStyle highlightedButtonStyle() {
    return ElevatedButton.styleFrom(
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      padding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      shape: CircleBorder(),
      primary: TdColor.darkGray,
    );
  }
}
