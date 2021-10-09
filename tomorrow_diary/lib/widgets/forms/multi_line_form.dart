import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class MultiLineForm extends StatelessWidget {
  final String hint;
  final String? text;
  final int minLines;
  void Function(String) onChanged;
  MultiLineForm(
      {Key? key,
      this.hint = '',
      this.minLines = 3,
      this.text,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      cursorColor: Colors.white,
      maxLines: null,
      minLines: minLines,
      initialValue: text,
       style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(TdSize.s),
        fillColor: Colors.white10,
        filled: true,
        label: Text("$hint"),
        labelStyle: TextStyle(color: Colors.white38),
        //hintText: hint,
        //hintStyle:
            //GoogleFonts.notoSans(color: TdColor.gray, fontSize: TdSize.s),
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
