import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String text;
  SubmitButtonWidget({required this.text});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: TextWidget.title(text: 'testtext'),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TdSize.radiusM),
          ),
        ),
      ),
    );
  }
}
