import 'dart:convert';

class Wish {
  Wish({
    this.wish,
    this.checked,
  });

  String? wish;
  bool? checked;

  factory Wish.fromJson(String str) => Wish.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wish.fromMap(Map<String, dynamic> json) => Wish(
        wish: json["wish"] == null ? null : json["wish"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toMap() => {
        "wish": wish == null ? null : wish,
        "checked": checked == null ? null : checked,
      };
}
