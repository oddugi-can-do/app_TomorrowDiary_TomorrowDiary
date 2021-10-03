import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TmrDiaryScreen extends StatelessWidget {
  static const pageId = '/write/tmrdiary';

  TmrDiary? tmrDiary;
  TmrDiaryScreen({required this.tmrDiary});

  Future<dynamic> buildTmrDiaryModal(BuildContext context) {
    List<Widget> _listItems = [];
    if (tmrDiary != null) {
      _listItems = _addListItemsFromTmrDiary(tmrDiary!);
    } else {
      _listItems = _addDefaultTmrListItems();
    }
    return ModalUtil.barModalWithListItems(context, _listItems, '내일의 일기');
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);
  List<Widget> _addListItemsFromTmrDiary(TmrDiary tmrDiary) {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(tmrDiary.title == null
        ? SingleLineForm(hint: '내일의 일기 제목')
        : SingleLineForm(text: tmrDiary.title!));
    _listItems.add(_largeGap);
    // ---내일 있어야 할 일---
    _listItems.add(const TextWidget.body(text: '내일 있어야 할 일'));
    _listItems.add(_smallGap);
    _listItems.add(tmrDiary.tmrHappen == null
        ? const MultiLineForm(hint: '내일 있어야 할 일을 최대한 객관적으로 적어주세요')
        : MultiLineForm(text: tmrDiary.tmrHappen!));
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '내일 기대하고 있는 일'));
    _listItems.addAll(ModalUtil.widgetFromStringList(tmrDiary.tmrWish));
    _listItems.add(_largeGap);
    // ---내일의 기분 예측---
    _listItems.add(const TextWidget.body(text: '내일의 기분'));
    _listItems.add(_smallGap);
    _listItems.add(tmrDiary.title == null
        ? SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.')
        : SingleLineForm(text: tmrDiary.tmrEmotion!));
    _listItems.add(_largeGap);
    // ---작성 완료 버튼---
    _listItems.add(SubmitButtonWidget(text: '작성 완료'));
    return _listItems;
  }

  List<Widget> _addDefaultTmrListItems() {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(SingleLineForm(hint: '내일의 일기 제목'));
    _listItems.add(_largeGap);
    // ---내일 있어야 할 일---
    _listItems.add(const TextWidget.body(text: '내일 있어야 할 일'));
    _listItems.add(_smallGap);
    _listItems.add(const MultiLineForm(hint: '내일 있어야 할 일을 최대한 객관적으로 적어주세요'));
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '내일 기대하고 있는 일'));
    _listItems.addAll(ModalUtil.widgetFromStringList([]));
    _listItems.add(_largeGap);
    // ---내일의 기분 예측---
    _listItems.add(const TextWidget.body(text: '내일의 기분'));
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
