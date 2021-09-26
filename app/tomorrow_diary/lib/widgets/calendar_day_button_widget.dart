import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class CalendarDayButtonWidget extends StatelessWidget {
  final String text;
  bool isEnabled;
  CalendarDayButtonWidget({required this.text}) : isEnabled = true;
  CalendarDayButtonWidget.disabled()
      : text = '',
        isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: TextWidget.body(text: text),
      autofocus: false,
      style: ElevatedButton.styleFrom(
        enableFeedback: false,
        shadowColor: Colors.transparent,
        fixedSize: Size(TdSize.xxl * 2, TdSize.xxl * 2),
        shape: CircleBorder(),
        primary: Colors.transparent,
        elevation: 0,
        // minimumSize: Size(TdSize.xxl, TdSize.xxl),
        onPrimary: Colors.transparent,
      ),
    );
  }
}
