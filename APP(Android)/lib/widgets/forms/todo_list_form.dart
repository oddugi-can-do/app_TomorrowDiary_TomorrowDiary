import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
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
  @override
  Widget build(BuildContext context) {
    TodoFormController t = Get.find();
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => Column(
              children: [
                Container(
                  height: 50,
                  child: SingleLineForm(
                    hint: 'Todolist hint',
                    onChanged: (value) {
                      t.setTitle(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            t.toggleTimeEnabled();
                          },
                          icon: t.isTimeEnabled
                              ? const Icon(Icons.check_box_rounded)
                              : const Icon(
                                  Icons.check_box_outline_blank_rounded),
                          label: const TextWidget.hint(text: '시간'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TdSize.radiusM),
                            ),
                            primary: TdColor.brown,
                          )),
                      const SizedBox(width: 20),
                      Expanded(
                        child: t.isTimeEnabled
                            ? TimeSelectWidget(
                                key: UniqueKey(),
                                text: t.start,
                                onChanged: (value) {
                                  t.setStart(value);
                                },
                              )
                            : TimeSelectWidget.disable(
                                text: '-',
                                onChanged: (value) {},
                              ),
                      ),
                      const SizedBox(width: 5),
                      const Center(child: TextWidget.body(text: '~')),
                      const SizedBox(width: 5),
                      Expanded(
                        child: t.isTimeEnabled
                            ? TimeSelectWidget(
                                key: UniqueKey(),
                                text: t.end,
                                onChanged: (value) {
                                  t.setEnd(value);
                                },
                              )
                            : TimeSelectWidget.disable(
                                text: '-',
                                onChanged: (value) {},
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmitted(t.todo);
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
