import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

import 'utils.dart';

class ModalUtil {

  static Future<dynamic> barModalWithTyDiaryScreen(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TyDiaryScreen(),
      ),
    );
  }

  static Future<dynamic> barModalWithTmrDiaryScreen(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TmrDiaryScreen(),
      ),
    );
  }
}
