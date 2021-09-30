import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class ServeWidget extends StatelessWidget with PrintLogMixin {
  final double height;
  final String text;
  final Color color;
  const ServeWidget({Key? key, required this.text, required this.color})
      : height = 100,
        super(key: key);
  // 왼쪽 바는 가로의 0.05%이다.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        printLog('serve widget tapped');
        Get.bottomSheet(
          Container(
            height: 150,
            color: Colors.greenAccent,
            child: Column(
              children: [
                Text('Hii 1', textScaleFactor: 2),
                Text('Hii 2', textScaleFactor: 2),
                Text('Hii 3', textScaleFactor: 2),
                Text('Hii 4', textScaleFactor: 2),
              ],
            ),
          ),
        );
        printLog('serve get.bottom');
      },
      child: Stack(
        children: [
          Container(
            // width: size.width,
            height: height,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: TdColor.gray,
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
              color: Colors.transparent,
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
