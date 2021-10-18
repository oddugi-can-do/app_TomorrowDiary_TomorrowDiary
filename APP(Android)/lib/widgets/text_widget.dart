import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextCategory { title, header, body, hint, calendar }

class TextWidget extends StatelessWidget {
  final String text;
  final TextCategory textCategory;
  final double fontSize;
  final Color color;
  const TextWidget.calendar(
      {required this.text, required this.fontSize, this.color = TdColor.white})
      : textCategory = TextCategory.calendar;
  const TextWidget.title({
    required this.text,
    this.fontSize = TdSize.xxl,
    this.color = TdColor.white,
  }) : textCategory = TextCategory.title;
  const TextWidget.header({
    required this.text,
    this.fontSize = TdSize.l,
    this.color = TdColor.white,
  }) : textCategory = TextCategory.header;
  const TextWidget.todoHeader({
    required this.text,
    this.fontSize = TdSize.m,
    this.color = TdColor.white,
  }) : textCategory = TextCategory.header;
  const TextWidget.body({
    required this.text,
    this.fontSize = TdSize.m,
    this.color = TdColor.white,
  }) : textCategory = TextCategory.body;
  const TextWidget.hint({
    required this.text,
    this.fontSize = TdSize.s,
    this.color = TdColor.white,
  }) : textCategory = TextCategory.hint;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(color: color, fontSize: fontSize),
    );
  }
}
