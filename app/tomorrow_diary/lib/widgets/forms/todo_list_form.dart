import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TodoListForm extends StatefulWidget {
  final String hint;
  TodoListForm({Key? key, required this.hint}) : super(key: key);

  @override
  State<TodoListForm> createState() => _TodoListFormState();
}

class _TodoListFormState extends State<TodoListForm> {
  bool isEnabled = true;
  String? text = '';
  String? start;
  String? end;
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
                    text = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isEnabled = !isEnabled;
                          });
                        },
                        icon: isEnabled
                            ? Icon(Icons.check_box_rounded)
                            : Icon(Icons.check_box_outline_blank_rounded),
                        label: TextWidget.hint(text: '시간'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TdSize.radiusM),
                          ),
                          primary: TdColor.blue,
                        )),
                    SizedBox(width: 20),
                    Expanded(
                      child: isEnabled
                          ? TimeSelectWidget(
                              text: 'start',
                              onChanged: (value) {
                                start = value;
                              })
                          : TimeSelectWidget.disable(text: '-'),
                    ),
                    SizedBox(width: 20),
                    Center(child: TextWidget.body(text: '~')),
                    SizedBox(width: 20),
                    Expanded(
                      child: isEnabled
                          ? TimeSelectWidget(
                              text: 'end',
                              onChanged: (value) {
                                end = value;
                              })
                          : TimeSelectWidget.disable(text: '-'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            DiaryController d = Get.find();
            d.allData.value.todoList?.add(
              Todo(
                todo: text,
                start: start,
                end: end,
                checked: false,
                timeEnabled: isEnabled,
              ),
            );
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
            primary: TdColor.blue,
          ),
        ),
      ],
    );
/*
    return Container(
      height: 500,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: TdColor.lightGreen,
            child: Column(
              children: [
                Container(
                  height: TdSize.l,
                  width: 500,
                  child: SingleLineForm(hint: hint),
                ),
                Container(
                  color: TdColor.lightBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.check_box_outline_blank_rounded),
                        label: Container(),
                      ),
                      Expanded(child: TimeSelectWidget(text: '시작시간')),
                      Expanded(child: TimeSelectWidget(text: '종료시간')),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: TdColor.lightRed,
            child: ElevatedButton(
              onPressed: onSubmitted,
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                shape: const CircleBorder(),
                primary: TdColor.blue,
              ),
            ),
          ),
        ],
      ),
    );*/
  }
}
