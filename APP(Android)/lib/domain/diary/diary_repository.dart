
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/domain/diary/diary_provider.dart';
import 'package:tomorrow_diary/models/models.dart';

class DiaryRepository {
  UserController u = Get.find<UserController>();
  final DiaryProvider _diaryProvider = DiaryProvider();

  Future<DataModel> findDataByDate(String date) async {
    DocumentSnapshot result = await _diaryProvider.findDataByDate(date);
    if (result.data() == null) {
      print('result.data() is null. return emtpy DataModel()');
      return DataModel();
    } else {
      return DataModel.fromMap(result.data() as Map<String, dynamic>);
    }
  }

  //성공하면 1, 실패하면 -1
  Future<int> setDataByDate(String date, DataModel data) async {
    await _diaryProvider.setDataByDate(date, data);
    DataModel foundData = await findDataByDate(date);
    return foundData.tyDiary == data.tyDiary &&
            foundData.tmrDiary == data.tmrDiary &&
            listEquals(foundData.todoList, data.todoList)
        ? 1
        : -1;
  }
}
