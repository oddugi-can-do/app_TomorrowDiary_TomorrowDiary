import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class CalendarDayButtonWidget extends StatefulWidget {
  int day = 0;
  String get text => '$day';
  bool isEnabled;
  bool isHighlighted;
  CalendarController controller;
  CalendarDayButtonWidget(
      {Key? key, required this.day, required this.controller})
      : isEnabled = true,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.disabled({Key? key, required this.controller})
      : isEnabled = false,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.highlighted(
      {Key? key, required this.day, required this.controller})
      : isEnabled = true,
        isHighlighted = true,
        super(key: key);

  @override
  _CalendarDayButtonWidgetState createState() =>
      _CalendarDayButtonWidgetState();
}

class _CalendarDayButtonWidgetState extends State<CalendarDayButtonWidget>
    with PrintLogMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEnabled
        ? widget.isHighlighted
            ? _highlightedContainerBuilder()
            : _enabledContainerBuilder()
        : _disabledContainerBuilder();
  }

  GetBuilder<CalendarController> _enabledContainerBuilder() {
    return GetBuilder<CalendarController>(
      init: widget.controller,
      builder: (controller) {
        return controller.isSelected(widget.day)
            ? ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: TextWidget.body(text: widget.text),
                style: selectedButtonStyle(),
              )
            : ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: TextWidget.body(text: widget.text),
                style: unselectedButtonStyle(),
              );
      },
    );
  }

  GetBuilder<CalendarController> _highlightedContainerBuilder() {
    return GetBuilder<CalendarController>(
      init: widget.controller,
      builder: (controller) {
        return controller.isSelected(widget.day)
            ? ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: TextWidget.body(text: widget.text),
                style: selectedButtonStyle(),
              )
            : ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: TextWidget.body(text: widget.text),
                style: highlightedButtonStyle(),
              );
      },
    );
  }

  Widget _disabledContainerBuilder() {
    return Container(
      width: TdSize.xxl,
      height: TdSize.xxl,
    );
  }

  ButtonStyle selectedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: TdColor.blue,
    );
  }

  ButtonStyle unselectedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: Colors.transparent,
    );
  }

  ButtonStyle highlightedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: TdColor.darkGray,
    );
  }
}
