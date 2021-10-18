import 'package:tomorrow_diary/models/emotion_model.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  bool? isAdmin;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.isAdmin = false,
  });



  /* 데이터를 Dart형태로 바꾸는 작업 , 시리얼라이징은 데이터를 String 형태(Encode) 
  디시리얼라이징은 String을 dart의 데이터 구조로 바꾸는 작업(Decode)*/
  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        username = json['username'],
        isAdmin = json['isAdmin'];

  /*데이터를 보내기위해 데이터를 가공*/
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username" : username,
        "isAdmin" : isAdmin,
      };
  
  
}
