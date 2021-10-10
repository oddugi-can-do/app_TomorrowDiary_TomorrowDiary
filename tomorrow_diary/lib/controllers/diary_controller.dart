import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/diary/diary_repository.dart';
import 'package:tomorrow_diary/models/models.dart';

import 'controllers.dart';

class DiaryController extends GetxController {
  final DiaryRepository _diaryRepository = DiaryRepository();
  final allData = DataModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<DataModel> findDataByDate(String date) async {
    DataModel foundData = await _diaryRepository.findDataByDate(date);
    allData.value = foundData;
    allData.value.tmrDiary ??= TmrDiary(
      title: '',
      tmrWish: <Wish>[],
      tmrEmotion: '',
      tmrHappen: '',
    );
    allData.value.tyDiary ??= TyDiary(
      title: '',
      tyWish: <Wish>[],
      tyEmotion: '',
      tySurprise: '',
      tyHappen: '',
    );
    allData.value.todoList ??= <Todo>[];
    return allData.value;
  }

  Future<void> setDataByDate(String date, DataModel data) async {
    print('in controller : data.tmrDiary.title : ${data.tmrDiary?.title}');
    int result = await _diaryRepository.setDataByDate(date, data);
    if (result == 1) {
      DataModel foundData = await _diaryRepository.findDataByDate(date);
      allData.value = foundData;
    }
  }

  Future<void> setPresentData() async {
    CalendarController c = Get.find();
    String _date = c.selectedDate;
    int result = await _diaryRepository.setDataByDate(_date, allData.value);
    if (result == 1) {
      DataModel foundData = await _diaryRepository.findDataByDate(_date);
      allData.value = foundData;
    }
  }
}
