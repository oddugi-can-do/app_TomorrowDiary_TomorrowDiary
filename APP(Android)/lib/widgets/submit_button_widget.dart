import 'package:flutter/material.dart';

import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String text;
  void Function() onSubmitted;
  SubmitButtonWidget({required this.text, required this.onSubmitted});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onSubmitted();
        Navigator.of(context).pop();
      },
      child: TextWidget.body(text: text),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        minimumSize: Size(TdSize.xxl * 2, TdSize.xxl * 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
        ),
        primary: TdColor.brown,
      ),
    );
  }
}
