import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class MultiLineForm extends StatelessWidget {
  final String hint;
  final int minLines;
  const MultiLineForm({Key? key, required this.hint, this.minLines = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      minLines: minLines,
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
