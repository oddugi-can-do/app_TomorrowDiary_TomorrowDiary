import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/views/views.dart';

import 'utils.dart';

class ModalUtil {
  static Future<dynamic> barModalWithTyDiaryScreen(
      BuildContext context, TimePoint timePoint) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TyDiaryScreen(isEditable: timePoint == TimePoint.present),
      ),
    );
  }

  static Future<dynamic> barModalWithTmrDiaryScreen(
      BuildContext context, TimePoint timePoint) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TmrDiaryScreen(isEditable: timePoint == TimePoint.tomorrow),
      ),
    );
  }

  static Future<dynamic> barModalWithTodoListScreen(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TodoListScreen(),
      ),
    );
  }
}
