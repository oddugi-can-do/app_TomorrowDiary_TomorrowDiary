import 'dart:convert';
import 'package:tomorrow_diary/models/models.dart';

class DataModel {
  DataModel({
    this.tmrDiary,
    this.todoList,
    this.tyDiary,
  });

  TmrDiary? tmrDiary;
  List<Todo>? todoList;
  TyDiary? tyDiary;

  factory DataModel.fromJson(String str) => DataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        tmrDiary: json["tmr_diary"] == null
            ? null
            : TmrDiary.fromMap(json["tmr_diary"]),
        todoList: json["todo_list"] == null
            ? null
            : List<Todo>.from(
                json["todo_list"].map((x) => Todo.fromMap(x))),
        tyDiary:
            json["ty_diary"] == null ? null : TyDiary.fromMap(json["ty_diary"]),
      );

  Map<String, dynamic> toMap() => {
        "tmr_diary": tmrDiary == null ? null : tmrDiary!.toMap(),
        "todo_list": todoList == null
            ? null
            : List<dynamic>.from(todoList!.map((x) => x.toMap())),
        "ty_diary": tyDiary == null ? null : tyDiary!.toMap(),
      };
}
