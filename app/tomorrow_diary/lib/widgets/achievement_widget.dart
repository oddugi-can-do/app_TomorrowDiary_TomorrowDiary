import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class AchievementWidget extends StatelessWidget {
  final String title;
  final String description;
  const AchievementWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TdSize.xxxl,
      child: ElevatedButton(
        onPressed: null,
        child: Column(
          children: [
            TextWidget.header(text: title),
            TextWidget.body(text: description),
          ],
        ),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TdSize.radiusM),
          ),
          primary: TdColor.purple,
        ),
      ),
    );
  }
}
