import 'package:get/get.dart';
import 'package:tomorrow_diary/domain/diary/diary_repository.dart';
import 'package:tomorrow_diary/models/models.dart';

class DiaryController extends GetxController {
  final DiaryRepository _diaryRepository = DiaryRepository();
  final allData = DataModel().obs;
  final initialDate = "2021-10-03"; // TODO: initialDate가 꼭 필요한가?

  @override
  void onInit() {
    super.onInit();
    findDataByDate(initialDate);
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

  Future<void> setPresentDataByDate(String date) async {
    // TODO: date도 안받아도 될듯?
    int result = await _diaryRepository.setDataByDate(date, allData.value);
    if (result == 1) {
      DataModel foundData = await _diaryRepository.findDataByDate(date);
      allData.value = foundData;
    }
  }
}
