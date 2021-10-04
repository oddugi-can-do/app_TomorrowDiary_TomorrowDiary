import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TodoWidget extends StatefulWidget {
  Todo todo;
  void Function(bool) onTap;
  TodoWidget({Key? key, required this.todo, required this.onTap})
      : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  Todo todo = Todo();
  @override
  void initState() {
    super.initState();
    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('todo checked : ${todo.checked}');
        setState(() {
          switch (todo.checked ?? false) {
            case true:
              todo.checked = false;
              widget.todo = todo;
              widget.onTap(false);
              break;
            case false:
              todo.checked = true;
              widget.todo = todo;
              widget.onTap(true);
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: todo.checked ?? false ? TdColor.purple : TdColor.darkGray,
            borderRadius:
                const BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            todo.timeEnabled ?? false
                ? const Icon(Icons.circle, size: TdSize.m)
                : const Icon(Icons.circle_outlined, size: TdSize.m),
            const SizedBox(width: TdSize.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget.header(text: todo.todo ?? ''),
                if (todo.timeEnabled ?? false)
                  TextWidget.body(
                    text: '${todo.start ?? ''} ~ ${todo.end ?? ''}',
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
