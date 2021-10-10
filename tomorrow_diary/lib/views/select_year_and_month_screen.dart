import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class SelectYearAndMonthScreen extends StatefulWidget {
  final int initialYear;
  final int initialMonth;
  void Function(int, int) onChanged;
  SelectYearAndMonthScreen(
      {Key? key,
      required this.initialYear,
      required this.initialMonth,
      required this.onChanged})
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
    print('on dispose');
    super.dispose();
    widget.onChanged(year, month);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: year - firstYear),
              itemExtent: TdSize.xxl,
              onSelectedItemChanged: (value) {
                print('onSelectedItemChanged: $value');
                year = value + 2019;
                print('and current year : $year');
              },
              children: [
                ...List.generate(
                    10,
                    (index) => Center(
                        child: TextWidget.body(text: '${index + firstYear}')))
              ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: month - 1),
              itemExtent: TdSize.xxl,
              onSelectedItemChanged: (value) {
                print('onSelectedItemChanged: $value');
                month = value + 1;
                print('and current month : $month');
              },
              children: [
                ...List.generate(
                    12,
                    (index) =>
                        Center(child: TextWidget.body(text: '${index + 1}')))
              ]),
        )
      ],
    );
    // return Scaffold(
    //   body: CupertinoPicker(
    //       firstDate: DateTime(2019),
    //       lastDate: DateTime(2050),
    //       initialDate: DateTime.now(),
    //       onChanged: (value) {
    //         year = value.year;
    //         month = value.month;
    //         widget.onChanged(year, month);
    //         Navigator.pop(context);
    //       }),
    // );
  }
}
