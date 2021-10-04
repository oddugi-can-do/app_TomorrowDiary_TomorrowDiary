import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/achievement/achievement_repository.dart';
import 'package:tomorrow_diary/models/achievement_model.dart';

class AchievementController extends GetxController {
  final AchievementRepository _achievementRepository = AchievementRepository();
  final achievements = Achievements(achievements: []).obs;

  Future<Achievements> findData() async {
    Achievements foundAchievements = await _achievementRepository.findData();
    return foundAchievements;
  }

  Future<void> setData() async {
    int result = await _achievementRepository.setData(achievements.value);
    if (result == 1) {
      Achievements foundAchievements = await _achievementRepository.findData();
      achievements.value = foundAchievements;
    }
  }
}
