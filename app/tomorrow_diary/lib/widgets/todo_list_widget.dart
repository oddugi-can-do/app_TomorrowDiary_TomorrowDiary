import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

enum TodoListState { checked, unchecked }

class TodoWidget extends StatefulWidget {
  TodoListState todoListState;
  String todo;
  String? timeStart;
  String? timeEnd;
  TodoWidget(
      {Key? key,
      this.todoListState = TodoListState.unchecked,
      this.todo = '',
      this.timeStart,
      this.timeEnd})
      : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          switch (widget.todoListState) {
            case TodoListState.checked:
              widget.todoListState = TodoListState.unchecked;
              break;
            case TodoListState.unchecked:
              widget.todoListState = TodoListState.checked;
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.todoListState == TodoListState.unchecked
                ? TdColor.darkGray
                : TdColor.purple,
            borderRadius:
                const BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            widget.todoListState == TodoListState.unchecked
                ? const Icon(Icons.circle_outlined, size: TdSize.m)
                : const Icon(Icons.circle, size: TdSize.m),
            const SizedBox(width: TdSize.s),
            widget.timeStart == null
                ? TextWidget.header(text: widget.todo)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget.header(text: widget.todo),
                      TextWidget.body(
                          text:
                              '${widget.timeStart} ~ ${widget.timeEnd ?? ''}'),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
