import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class SelectYearAndMonthScreen extends StatefulWidget {
  final int initialYear;
  final int initialMonth;
  void Function(int, int) onSubmitted;
  void Function() onCanceled;
  SelectYearAndMonthScreen(
      {Key? key,
      required this.initialYear,
      required this.initialMonth,
      required this.onSubmitted,
      required this.onCanceled})
      : super(key: key);

  @override
  _SelectYearAndMonthScreenState createState() =>
      _SelectYearAndMonthScreenState();
}

class _SelectYearAndMonthScreenState extends State<SelectYearAndMonthScreen> {
  final int firstYear = 2019;
  int year = 0;
  int month = 0;
  @override
  void initState() {
    super.initState();
    year = widget.initialYear;
    month = widget.initialMonth;
  }

  @override
  void dispose() {
    super.dispose();
    widget.onCanceled();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: year - firstYear),
                itemExtent: TdSize.xxl,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: TdColor.brown.withOpacity(0.4),
                ),
                onSelectedItemChanged: (value) {
                  year = value + 2019;
                },
                children: [
                  ...List.generate(
                      4,
                      (index) => Center(
                          child: TextWidget.body(text: '${index + firstYear}')))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: month - 1),
                itemExtent: TdSize.xxl,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: TdColor.brown.withOpacity(0.4),
                ),
                onSelectedItemChanged: (value) {
                  month = value + 1;
                },
                children: [
                  ...List.generate(
                      12,
                      (index) =>
                          Center(child: TextWidget.body(text: '${index + 1}')))
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TdSize.l),
          child: SubmitButtonWidget(
            text: '선택 완료',
            onSubmitted: () {
              dispose();
              widget.onSubmitted(year, month);
            },
          ),
        ),
      ],
    );
  }
}
