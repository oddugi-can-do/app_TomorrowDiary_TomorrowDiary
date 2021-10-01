import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class SingleLineForm extends StatelessWidget {
  final String hint;
  String text; // TODO: StreamBuilder로 바꾸기 (Rx)
  SingleLineForm({Key? key, required this.hint, this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(TdSize.s),
        fillColor: TdColor.darkGray,
        filled: true,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
