import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TodoListScreen extends StatefulWidget {
  static const pageId = '/wrtie/todolist';

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  DiaryController d = Get.find();
  CalendarController c = Get.find();
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    Get.put(TodoFormController());
    todoList = d.allData.value.todoList!;
  }

  @override
  void dispose() {
    d.setPresentData();
    c.selectDay(c.selectedDay);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: NestedScrollView(
          controller: ScrollController(),
          physics: const ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool isInnerBoxScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                        child: TextWidget.body(
                            text: 'To-do List : ${c.selectedDate}'),
                      ),
                    ),
                  )
                ]),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: TdSize.m, horizontal: TdSize.xl),
            physics: const AlwaysScrollableScrollPhysics(),
            // 이 physics를 추가 안하면 listview로 화면이 가득 차지 않을 때 버그가 남.
            controller: PrimaryScrollController.of(context),
            children: [
              for (int i = 0; i < todoList.length; ++i)
                Column(
                  children: [
                    _smallGap,
                    TodoWidget(
                        todo: todoList[i],
                        onTap: (checked) {
                          todoList[i].checked = checked;
                          _onTodoRefreshed(todoList);
                        },
                        onLongPressed: (deleted) {
                          if (deleted == true) {
                            todoList.removeAt(i);
                            _onTodoRefreshed(todoList);
                          }
                        }),
                  ],
                ),
              _smallGap,
              TodoListForm(
                hint: '할 일',
                onSubmitted: _onTodoSubmitted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);

  void _onTodoSubmitted(Todo value) {
    setState(() {
      todoList.add(value);
      d.allData.value.todoList = todoList;
      d.setPresentData();
      TodoFormController t = Get.find();
      t.resetData();
    });
  }

  void _onTodoRefreshed(List<Todo> value) {
    setState(() {
      todoList = value;
      d.allData.value.todoList = todoList;
      d.setPresentData();
    });
  }
}
