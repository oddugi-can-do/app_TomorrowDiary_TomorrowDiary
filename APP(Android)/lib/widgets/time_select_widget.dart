import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/utils/utils.dart';

import 'widgets.dart';

class TimeSelectWidget extends StatefulWidget {
  TimeSelectWidget({Key? key, required this.text, required this.onChanged})
      : isEnabled = true,
        super(key: key);
  TimeSelectWidget.disable({required this.text, required this.onChanged})
      : isEnabled = false;
  String text;
  bool isEnabled;
  void Function(String) onChanged;
  @override
  State<TimeSelectWidget> createState() => _TimeSelectWidgetState();
}

class _TimeSelectWidgetState extends State<TimeSelectWidget> {
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled
          ? () {
              Navigator.of(context)
                  .push(
                showPicker(
                  context: context,
                  value: _time,
                  onChange: (value) {
                    _time = value;
                  },
                  minuteInterval: MinuteInterval.FIVE,
                  disableHour: false,
                  disableMinute: false,
                  accentColor: TdColor.brown,
                  cancelText: "취소",
                  okText: "완료",
                  blurredBackground: true,
                  okCancelStyle: GoogleFonts.notoSans(
                      color: TdColor.brown, fontWeight: FontWeight.bold),
                ),
              )
                  .then((value) {
                if (value == null) {
                  print('canceled');
                } else {
                  print('ok');
                  widget.text = '${_time.hour}:${_time.minute}';

                  widget.onChanged('${_time.hour}:${_time.minute}');
                }
              });
            }
          : null,
      child: TextWidget.body(text: widget.text),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
        ),
        primary: widget.isEnabled ? TdColor.brown : TdColor.gray,
      ),
    );
  }
}
