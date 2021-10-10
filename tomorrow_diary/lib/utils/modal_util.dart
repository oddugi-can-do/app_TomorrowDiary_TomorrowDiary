import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/views/views.dart';

import 'utils.dart';

class ModalUtil {
  static Future<dynamic> barModalWithTyDiaryScreen(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      // expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: TyDiaryScreen()
        // Scaffold(resizeToAvoidBottomInset: true , body: TyDiaryScreen()),
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
