import 'dart:convert';

class Todo {
  Todo({
    this.end,
    this.start,
    this.todo,
    this.checked,
    this.timeEnabled,
  });

  String? end;
  String? start;
  String? todo;
  bool? checked;
  bool? timeEnabled;

  bool isEmpty() {
    if (todo == null || todo == '') {
      return true;
    }
    return false;
  }

  factory Todo.fromJson(String str) => Todo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        end: json["end"] == null ? null : json["end"],
        start: json["start"] == null ? null : json["start"],
        todo: json["todo"] == null ? null : json["todo"],
        checked: json["checked"] == null ? null : json["checked"],
        timeEnabled: json["time_enabled"] == null ? null : json["time_enabled"],
      );

  Map<String, dynamic> toMap() => {
        "end": end == null ? null : end,
        "start": start == null ? null : start,
        "todo": todo == null ? null : todo,
        "checked": checked == null ? null : checked,
        "time_enabled": timeEnabled == null ? null : timeEnabled,
      };
}
