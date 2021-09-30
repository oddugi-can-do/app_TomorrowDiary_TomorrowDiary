import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';


enum TextCategory { title, header, body, hint }

class TextWidget extends StatelessWidget {
  final String text;
  final TextCategory textCategory;
  const TextWidget()
      : text = '',
        textCategory = TextCategory.title;
  const TextWidget.title({required this.text})
      : textCategory = TextCategory.title;
  const TextWidget.header({required this.text})
      : textCategory = TextCategory.header;
  const TextWidget.body({required this.text})
      : textCategory = TextCategory.body;
  const TextWidget.hint({required this.text})
      : textCategory = TextCategory.hint;

  @override
  Widget build(BuildContext context) {
    Color _color = Colors.white;
    double _size = TdSize.l;

    switch (textCategory) {
      case TextCategory.title:
        _size = TdSize.xxl;
        break;
      case TextCategory.header:
        _size = TdSize.l;
        break;
      case TextCategory.body:
        _size = TdSize.m;
        break;
      case TextCategory.hint:
        _color = TdColor.lightGray;
        _size = TdSize.s;
        break;
      default:
    }
    return Text(
      text,
      style: GoogleFonts.notoSans(color: _color, fontSize: _size),
    );
  }
}
