import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TempTodoModel {
  String? todo;
  bool isTimeEnabled;
  TimeOfDay? start;
  TimeOfDay? end;

  TempTodoModel({this.todo, this.start, this.end, this.isTimeEnabled = false});
  TempTodoModel.withString(String startString, String endString, {this.todo})
      : start = TimeConverter.stringToTimeOfDay(startString),
        end = TimeConverter.stringToTimeOfDay(endString),
        isTimeEnabled = true;

  Widget makeTodoWidget() {
    if (isTimeEnabled) {
      return TodoWidget(
          todo: todo ?? '',
          timeStart: TimeConverter.timeOfDayToString(start!),
          timeEnd: TimeConverter.timeOfDayToString(end!));
    } else {
      return TodoWidget(todo: todo ?? '');
    }
  }
}

class TodoListScreen extends StatelessWidget {
  static const pageId = '/wrtie/todolist';
  List<Todo>? todoListData;

  TodoListScreen({required this.todoListData});

  Future<dynamic> buildTodoListModal(BuildContext context) {
    List<Widget> listItems = [
      const SizedBox(height: TdSize.l),
      ..._widgetFromTodoList(todoListData ?? []),
      TodoListForm(hint: '해야 할 일'),
    ];
    return ModalUtil.barModalWithListItems(context, listItems, 'To-do List');
  }

  List<Widget> _widgetFromTodoList(List<Todo> list) {
    List<Widget> _list = [];
    for (var element in list) {
      _list.add(_makeTodoWidget(element));
      _list.add(const SizedBox(height: TdSize.s));
    }
    return _list;
  }

  Widget _makeTodoWidget(Todo todo) {
    if (todo.timeEnabled ?? false) {
      return TodoWidget(
        todo: todo.todo ?? '',
        timeStart: todo.start,
        timeEnd: todo.end,
      );
    } else {
      return TodoWidget(todo: todo.todo ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
