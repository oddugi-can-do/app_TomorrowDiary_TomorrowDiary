import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class WishListForm extends StatelessWidget {
  final String hint;
  const WishListForm({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: MultiLineForm(
            hint: hint,
            minLines: 1,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            shape: const CircleBorder(),
            primary: TdColor.blue,
          ),
        ),
      ],
    );
  }
}
