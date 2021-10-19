import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TodoWidget extends StatefulWidget {
  Todo todo;
  void Function(bool) onTap;
  void Function(bool) onLongPressed;
  TodoWidget(
      {Key? key,
      required this.todo,
      required this.onTap,
      required this.onLongPressed})
      : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  Todo todo = Todo();
  var _tapPosition;

  @override
  void initState() {
    super.initState();
    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _showDeleteMenu,
      onTapDown: _storePosition,
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
            color: todo.checked ?? false ? TdColor.brown : TdColor.darkGray,
            borderRadius:
                const BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            todo.timeEnabled ?? false
                ? const Icon(CupertinoIcons.clock, size: TdSize.m)
                : const Icon(Icons.circle_outlined, size: TdSize.m),
            const SizedBox(width: TdSize.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget.todoHeader(text: todo.todo ?? ''),
                  if (todo.timeEnabled ?? false)
                    TextWidget.body(
                      text: '${todo.start ?? ''} ~ ${todo.end ?? ''}',
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteMenu() {
    print('show delete menu');
    final Size overlaySize =
        Overlay.of(context)!.context.findRenderObject()!.semanticBounds.size;

    print('overlay size defined');
    showMenu(
      elevation: 0,
      color: Colors.transparent,
      context: context,
      items: <PopupMenuEntry<bool>>[DeleteEntry()],
      position: RelativeRect.fromRect(
        _tapPosition & Size(0, 0), // smaller rect, the touch area
        Offset.zero & overlaySize, // Bigger rect, the entire screen
      ),
    ).then<void>((bool? delta) {
      if (delta == null) return;
      setState(() {
        widget.onLongPressed(delta);
      });
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
