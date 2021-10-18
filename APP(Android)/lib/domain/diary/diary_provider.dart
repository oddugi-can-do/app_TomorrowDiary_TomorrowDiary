import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/models/models.dart';

class DiaryProvider {
  final _collection = "Data";
  UserController u = Get.find<UserController>();

  //findAll() : User 컬렉션 -> 해당유저uid 다큐먼트
  Future<DocumentSnapshot> findAll() => FirebaseFirestore.instance
      .collection("users")
      .doc(u.principal.value.uid)
      .get();

  Future<DocumentSnapshot> findDataByDate(String date) =>
      FirebaseFirestore.instance
          .collection("users")
          .doc(u.principal.value.uid)
          .collection(_collection)
          .doc(date)
          .get();

  Future<void> setDataByDate(String date, DataModel data) {
    print(u.principal.value.uid);
    print(date);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(u.principal.value.uid)
        .collection(_collection)
        .doc(date)
        .set(data.toMap());
  }
}
