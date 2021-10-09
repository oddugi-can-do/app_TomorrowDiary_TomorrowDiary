import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class AchievementWidget extends StatelessWidget {
  final Achievement achievement;
  const AchievementWidget({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TdSize.xxl * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextWidget.body(text: achievement.title ?? ''),
          Wrap(
              children: [TextWidget.hint(text: achievement.description ?? '')]),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(TdSize.radiusM),
        ),
        border: Border.all(
          color: colorForGrade(achievement.grade),
          width: 3,
        ),
        color: Colors.transparent,
      ),
    );
  }

  Color colorForGrade(AchievementGrade ag) {
    if (ag == AchievementGrade.gold) {
      return TdColor.gold;
    } else if (ag == AchievementGrade.silver) {
      return TdColor.silver;
    } else {
      return TdColor.bronze;
    }
  }
}
