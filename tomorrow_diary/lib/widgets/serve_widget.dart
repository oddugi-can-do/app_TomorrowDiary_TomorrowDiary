import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class ServeWidget extends StatelessWidget {
  final double height;
  final String text;
  final Color color;
  final void Function() onPressed;
  const ServeWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.onPressed})
      : height = 100,
        super(key: key);
  // 왼쪽 바는 가로의 0.05%이다.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            height: height,
            child: Container(
              decoration: BoxDecoration(
                border : Border.all(color: TdColor.brown , width: 1),
                color: Colors.black87,
                borderRadius: BorderRadius.circular(TdSize.radiusM),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 300 * 0.05,
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(TdSize.radiusM),
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: 300 * 0.05 * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget.body(text: text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
