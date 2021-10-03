import 'dart:convert';

class TodoList {
  TodoList({
    this.end,
    this.start,
    this.todo,
    this.checked,
  });

  String? end;
  String? start;
  String? todo;
  bool? checked;

  factory TodoList.fromJson(String str) => TodoList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoList.fromMap(Map<String, dynamic> json) => TodoList(
        end: json["end"] == null ? null : json["end"],
        start: json["start"] == null ? null : json["start"],
        todo: json["todo"] == null ? null : json["todo"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toMap() => {
        "end": end == null ? null : end,
        "start": start == null ? null : start,
        "todo": todo == null ? null : todo,
        "checked": checked == null ? null : checked,
      };
}
