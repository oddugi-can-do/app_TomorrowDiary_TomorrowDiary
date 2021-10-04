import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class SingleLineForm extends StatelessWidget {
  String hint;
  String text;
  void Function(String) onChanged;
  SingleLineForm(
      {Key? key, this.hint = '', this.text = '', required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(TdSize.s),
        fillColor: TdColor.darkGray,
        filled: true,
        hintText: hint,
        hintStyle:
            GoogleFonts.notoSans(color: TdColor.gray, fontSize: TdSize.s),
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
