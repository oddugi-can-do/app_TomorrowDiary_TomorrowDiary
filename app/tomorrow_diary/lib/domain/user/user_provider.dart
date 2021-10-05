import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/models/models.dart';


class UserProvider {
  final _col = "users";

  Future<QuerySnapshot> getUserDataFb(String uid) => FirebaseFirestore.instance
      .collection(_col)
      .where("uid", isEqualTo: "$uid")
      .get();

  Future<void> sendUserDataFb(UserModel newUser, String uid) =>
       FirebaseFirestore.instance.collection(_col).doc(newUser.uid).set(newUser.toJson());
  
}
