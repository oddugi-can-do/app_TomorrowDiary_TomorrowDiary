import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TodoListForm extends StatefulWidget {
  final String hint;
  void Function(Todo) onSubmitted;
  TodoListForm({Key? key, required this.hint, required this.onSubmitted})
      : super(key: key);

  @override
  State<TodoListForm> createState() => _TodoListFormState();
}

class _TodoListFormState extends State<TodoListForm> {
  Todo _todo = Todo();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 50,
                child: SingleLineForm(
                  hint: 'todolist hint',
                  onChanged: (value) {
                    _todo.todo = value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                child: Row(
                  key: GlobalKey(),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _todo.timeEnabled = !(_todo.timeEnabled ?? false);
                          });
                        },
                        icon: _todo.timeEnabled ?? false
                            ? const Icon(Icons.check_box_rounded)
                            : const Icon(Icons.check_box_outline_blank_rounded),
                        label: const TextWidget.hint(text: '시간'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TdSize.radiusM),
                          ),
                          primary: TdColor.brown,
                        )),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _todo.timeEnabled ?? false
                          ? TimeSelectWidget(
                              text: _todo.start ?? 'start',
                              onChanged: (value) {
                                setState(() {
                                  _todo.start = value;
                                });
                              })
                          : TimeSelectWidget.disable(
                              text: '-',
                              onChanged: (value) {},
                            ),
                    ),
                    const SizedBox(width: 5),
                    const Center(child: TextWidget.body(text: '~')),
                    const SizedBox(width: 5),
                    Expanded(
                      child: _todo.timeEnabled ?? false
                          ? TimeSelectWidget(
                              text: _todo.end ?? 'end',
                              onChanged: (value) {
                                setState(() {
                                  _todo.end = value;
                                });
                              })
                          : TimeSelectWidget.disable(
                              text: '-', onChanged: (value) {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmitted(_todo);
          },
          child: Container(
            height: TdSize.xxl,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Icon(
              Icons.add,
              size: TdSize.xl,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: TdColor.brown,
          ),
        ),
      ],
    );
  }
}
