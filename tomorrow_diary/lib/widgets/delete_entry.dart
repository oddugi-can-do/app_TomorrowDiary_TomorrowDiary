import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class DeleteEntry extends PopupMenuEntry<bool> {
  @override
  double height = 0;

  @override
  bool represents(bool? b) => b == true;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<DeleteEntry> {
  void _delete() {
    Navigator.pop<bool>(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TdSize.radiusM),
          ),
          primary: Colors.red,
          minimumSize: const Size(25, 50)),
      onPressed: _delete,
      icon: Icon(CupertinoIcons.delete),
      label: TextWidget.body(text: '삭제'),
    );
  }
}
