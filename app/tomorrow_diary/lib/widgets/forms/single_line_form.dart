import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class SingleLineForm extends StatelessWidget {
  final String hint;
  const SingleLineForm({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: TdColor.darkGray,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TdSize.radiusM),
        ),
      ),
    );
  }
}
