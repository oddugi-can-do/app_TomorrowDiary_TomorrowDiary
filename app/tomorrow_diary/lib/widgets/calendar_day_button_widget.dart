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
      init: Get.find<CalendarController>(),
      builder: (controller) {
        return controller.isSelected(widget.day)
            ? ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Center(child: TextWidget.calendar(text: widget.text))),
                style: selectedButtonStyle(),
              )
            : ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Center(child: TextWidget.calendar(text: widget.text))),
                style: unselectedButtonStyle(),
              );
      },
    );
  }

  GetBuilder<CalendarController> _highlightedContainerBuilder() {
    return GetBuilder<CalendarController>(
      init: Get.find<CalendarController>(),
      builder: (controller) {
        return controller.isSelected(widget.day)
            ? ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Center(child: TextWidget.calendar(text: widget.text))),
                style: selectedButtonStyle(),
              )
            : ElevatedButton(
                onPressed: () {
                  controller.selectDay(widget.day);
                },
                child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Center(child: TextWidget.calendar(text: widget.text))),
                style: highlightedButtonStyle(),
              );
      },
    );
  }

  Widget _disabledContainerBuilder() {
    return Container(
        // width: TdSize.xxl,
        // height: TdSize.xxl,
        );
  }

  ButtonStyle selectedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      // fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: TdColor.blue,
    );
  }

  ButtonStyle unselectedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      // fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: Colors.transparent,
    );
  }

  ButtonStyle highlightedButtonStyle() {
    return ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      // fixedSize: Size(TdSize.xxl, TdSize.xxl),
      shape: CircleBorder(),
      primary: TdColor.darkGray,
    );
  }
}
