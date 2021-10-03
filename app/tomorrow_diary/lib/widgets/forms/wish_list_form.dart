import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class WishListForm extends StatelessWidget {
  final String hint;
  String text = '';
  WishListForm({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiaryController d = Get.find();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: MultiLineForm(
            hint: hint,
            minLines: 1,
            onChanged: (value) {
              text = value;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            d.allData.value.tmrDiary?.tmrWish
                ?.add(Wish(wish: text, checked: false));
          },
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
