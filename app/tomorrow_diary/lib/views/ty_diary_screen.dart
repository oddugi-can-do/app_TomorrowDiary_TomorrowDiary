import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TyDiaryScreen extends StatelessWidget {
  static const pageId = '/write/tydiary';
  TyDiary? tyDiary;
  TyDiaryScreen({required this.tyDiary});
  Future<dynamic> buildTyDiaryModal(BuildContext context) {
    List<Widget> _listItems = [];
    if (tyDiary != null) {
      _listItems = _addListItemsFromTyDiary(tyDiary!);
    } else {
      _listItems = _addDefaultTyListItems();
    }
    return ModalUtil.barModalWithListItems(context, _listItems, '오늘의 일기');
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);

  List<Widget> _addListItemsFromTyDiary(TyDiary tyDiary) {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(tyDiary.title == null
        ? SingleLineForm(hint: '오늘의 일기 제목')
        : SingleLineForm(text: tyDiary.title!));
    _listItems.add(_largeGap);
    // ---오늘 있었던 일---
    _listItems.add(const TextWidget.body(text: '오늘 있었던 일'));
    _listItems.add(_smallGap);
    _listItems.add(tyDiary.tyHappen == null
        ? const MultiLineForm(hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요')
        : MultiLineForm(text: tyDiary.tyHappen!));
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '위시리스트'));
    _listItems.addAll(ModalUtil.widgetFromStringList(tyDiary.tyWish));
    _listItems.add(_largeGap);
    // ---오늘 깜짝! 놀랐던 일---
    _listItems.add(const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'));
    _listItems.add(const SizedBox(height: TdSize.s));
    _listItems.add(tyDiary.tyHappen == null
        ? const MultiLineForm(hint: '예상치 못한 일이 있었나요?')
        : MultiLineForm(text: tyDiary.tySurprise!));
    _listItems.add(_largeGap);
    // ---오늘의 진짜 기분---
    _listItems.add(const TextWidget.body(text: '오늘의 진짜 기분'));
    _listItems.add(_smallGap);
    _listItems.add(tyDiary.title == null
        ? SingleLineForm(hint: '오늘의 진짜 기분은 어땠나요?')
        : SingleLineForm(text: tyDiary.tyEmotion!));
    _listItems.add(_largeGap);
    // ---작성 완료 버튼---
    _listItems.add(SubmitButtonWidget(text: '작성 완료'));
    return _listItems;
  }

  List<Widget> _addDefaultTyListItems() {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(SingleLineForm(hint: '오늘의 일기 제목'));
    _listItems.add(_largeGap);
    // ---오늘 있었던 일---
    _listItems.add(const TextWidget.body(text: '오늘 있었던 일'));
    _listItems.add(_smallGap);
    _listItems.add(const MultiLineForm(hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요'));
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '위시리스트'));
    _listItems.add(_smallGap);
    _listItems.add(const TextWidget.hint(text: '설정된 위시리스트가 없습니다.'));
    _listItems.add(_largeGap);
    // ---오늘 깜짝! 놀랐던 일---
    _listItems.add(const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'));
    _listItems.add(const SizedBox(height: TdSize.s));
    _listItems.add(const MultiLineForm(hint: '예상치 못한 일이 있었나요?'));
    _listItems.add(_largeGap);
    // ---오늘의 진짜 기분---
    _listItems.add(const TextWidget.body(text: '오늘의 진짜 기분'));
    _listItems.add(_smallGap);
    _listItems.add(SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.'));
    _listItems.add(_largeGap);
    // ---작성 완료 버튼---
    _listItems.add(SubmitButtonWidget(text: '작성 완료'));
    return _listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
