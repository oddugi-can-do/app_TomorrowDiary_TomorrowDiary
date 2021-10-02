import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TyDiaryScreen extends StatelessWidget {
  static const pageId = '/write/tddiary';

  List<String> wishListData;
  TyDiaryScreen({required this.wishListData});
  Future<dynamic> buildTyDiaryModal(BuildContext context) {
    List<Widget> _listItems = [
      SingleLineForm(hint: '오늘의 일기 제목'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘 있었던 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '위시리스트'),
      ...ModalUtil.widgetFromStringList(wishListData),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '예상치 못한 일이 있었나요?'),
      const SizedBox(height: TdSize.l),
      const TextWidget.body(text: '오늘의 진짜 기분'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.'),
      const SizedBox(height: TdSize.l),
      SubmitButtonWidget(text: '작성 완료'),
    ];
    return ModalUtil.barModalWithListItems(context, _listItems, '오늘의 일기');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
