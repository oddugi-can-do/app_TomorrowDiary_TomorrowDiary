import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/diary/diary_repository.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/calendar_util.dart';
import 'package:tomorrow_diary/utils/date_converter.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'controllers.dart';

class DiaryController extends GetxController {
  final DiaryRepository _diaryRepository = DiaryRepository();
  final allData = DataModel().obs;
  final analysisData = <DataModel>[].obs;
  final tyEmotion = "".obs;
  final beforeTyDiary = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<DataModel>> findDataByMonth(int year, int month) async {
    print('diary controller : find data by month');
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
    //내일의 일기가 채워져있고, 오늘의 일기가 비워져 있고, 선택한 날짜가 오늘이면 오늘의 일기 자동완성.
    if (!allData.value.tmrDiary!.isEmpty() &&
        allData.value.tyDiary!.isEmpty() &&
        CalendarUtil.decidePastPresentFutureWithDate(date) ==
            TimePoint.present) {
      allData.value.tyDiary!.tyHappen = allData.value.tmrDiary!.tmrHappen;
      allData.value.tyDiary!.tyWish = [...allData.value.tmrDiary!.tmrWish!];
      allData.value.tyDiary!.tyEmotion = allData.value.tmrDiary!.tmrEmotion;
    }
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

  Future<List<DataModel>> getAnalyzedData() async {
    return analysisData;
  }

  Future<void> getTextEmotion(String? text) async {
    if(text == null || text == '') {
      snackBar(msg: "오늘의 일기를 작성해주세요!");
      return;
    }
    final res = await httpPostText(text);
    num max = 0.0;
    String emotion = "";
    Map<String,dynamic> resData = jsonDecode(res.body);

    resData.forEach((key, value) {
      if(value > max) {
        max = value;
        emotion = key;
      }
      });
    tyEmotion.value = emotion;
  }

  bool compareTyDiary(String? todayDiary) {
    if(todayDiary == '' || todayDiary == null || beforeTyDiary == todayDiary) {
      return false;
    }
  return true;
  }

}
