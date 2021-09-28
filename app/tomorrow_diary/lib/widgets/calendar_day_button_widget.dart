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
  CalendarController controller;
  CalendarDayButtonWidget(
      {Key? key, required this.day, required this.controller})
      : isEnabled = true,
        super(key: key);
  CalendarDayButtonWidget.disabled({Key? key, required this.controller})
      : isEnabled = false,
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
        ? GetBuilder<CalendarController>(
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
          )
        : _disabledContainerBuilder();
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

  Widget _disabledContainerBuilder() {
    return Container(
      width: TdSize.xxl,
      height: TdSize.xxl,
    );
  }
}
