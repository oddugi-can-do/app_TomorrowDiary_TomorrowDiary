import 'dart:convert';

import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/diary/diary_repository.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/calendar_util.dart';
import 'package:tomorrow_diary/utils/date_converter.dart';
import 'controllers.dart';

class DiaryController extends GetxController {
  final DiaryRepository _diaryRepository = DiaryRepository();
  final allData = DataModel().obs;
  final analysisData = <DataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<DataModel>> findDataByMonth(int year, int month) async {
    List<DataModel> foundData = [];
    for (int i = 0; i < CalendarUtil.daysCount(2021, 10); ++i) {
      DataModel _temp = await _diaryRepository
          .findDataByDate(DateConverter.dateToString(year, month, i));
      foundData.add(_temp);
    }
    analysisData.value = foundData;
    return foundData;
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
