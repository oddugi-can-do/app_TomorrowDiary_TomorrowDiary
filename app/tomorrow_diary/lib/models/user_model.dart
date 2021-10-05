import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/firestore_key.dart';

class UserModel {
  final String? uid;
  final String? email;

  UserModel({
    this.uid,
    this.email,
  });



  /* 데이터를 Dart형태로 바꾸는 작업 , 시리얼라이징은 데이터를 String 형태(Encode) 
  디시리얼라이징은 String을 dart의 데이터 구조로 바꾸는 작업(Decode)*/
  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"];

  /*데이터를 보내기위해 데이터를 가공*/
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
      };
}
