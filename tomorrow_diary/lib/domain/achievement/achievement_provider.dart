import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/models/achievement_model.dart';

class AchievementProvider {
  final _collection = "achievements";
  UserController u = Get.find<UserController>();

  Future<DocumentSnapshot> findData() => FirebaseFirestore.instance
      .collection(_collection)
      .doc(u.principal.value.uid)
      .get();

  Future<void> setData(Achievements data) {
    return FirebaseFirestore.instance
        .collection(_collection)
        .doc(u.principal.value.uid)
        .set(data.toMap());
  }
}
