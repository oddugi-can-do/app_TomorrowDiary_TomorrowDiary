import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/domain/achievement/achievement_provider.dart';
import 'package:tomorrow_diary/models/models.dart';

class AchievementRepository {
  UserController u = Get.find<UserController>();
  final AchievementProvider _provider = AchievementProvider();

  Future<Achievements> findData() async {
    DocumentSnapshot result = await _provider.findData();
    if (result.data() == null) {
      print('achievement empty.');
      return Achievements();
    } else {
      return Achievements.fromMap(result.data() as Map<String, dynamic>);
    }
  }

  Future<int> setData(Achievements data) async {
    print('set data with : ${data.achievements.toString()}');
    await _provider.setData(data);
    Achievements foundData = await findData();
    return listEquals(foundData.achievements, data.achievements) ? 1 : -1;
  }
}
