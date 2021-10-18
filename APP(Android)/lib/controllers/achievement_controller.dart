import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/achievement/achievement_repository.dart';
import 'package:tomorrow_diary/models/achievement_model.dart';
import 'package:tomorrow_diary/models/models.dart';

class AchievementController extends GetxController {
  final AchievementRepository _achievementRepository = AchievementRepository();
  final achievements = Achievements().obs;

  Future<Achievements> findData() async {
    Achievements foundAchievements = await _achievementRepository.findData();
    achievements.value = foundAchievements;
    return foundAchievements;
  }

  Future<void> setData() async {
    int result = await _achievementRepository.setData(achievements.value);
    if (result == 1) {
      Achievements foundAchievements = await _achievementRepository.findData();
      achievements.value = foundAchievements;
      print(
          'achievements value : ${foundAchievements.achievements!.first.title}');
    } else {
      print('something went wrong');
    }
  }

  Future<void> setDataWithAchievementList(AchievementType a) async {
    bool isDuplicated = false;
    //중복 검사!
    for (var item in achievements.value.achievements ?? []) {
      if (item.title == AchievementManager.allAchievement[a]![0]) {
        isDuplicated = true;
        break;
      }
    }
    //통과하면 추가!
    if (!isDuplicated) {
      String _title = AchievementManager.allAchievement[a]![0];
      String _description = AchievementManager.allAchievement[a]![1];
      String _gradeString = AchievementManager.allAchievement[a]![2];
      if (achievements.value.achievements == null) {
        achievements.value.achievements = [
          Achievement(
              title: _title,
              description: _description,
              gradeString: _gradeString)
        ];
      } else {
        achievements.value.achievements!.add(
          Achievement(
            title: _title,
            description: _description,
            gradeString: _gradeString,
          ),
        );
      }
      print('achievement 추가(controller), title:$_title, des:$_description');
      int result = await _achievementRepository.setData(achievements.value);
      if (result == 1) {
        Achievements foundAchievements =
            await _achievementRepository.findData();
        achievements.value = foundAchievements;
        print(
            'achievements value : ${foundAchievements.achievements!.first.title}');
      } else {
        print('something went wrong in controller');
      }
    }
  }
}
