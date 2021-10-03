import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TmrDiaryScreen extends StatelessWidget {
  static const pageId = '/write/tmrdiary';

  List<Wish> wishListData = [];

  TmrDiaryScreen({required this.wishListData});

  Future<dynamic> buildTmrDiaryModal(BuildContext context) {
    List<Widget> listItems = [
      SingleLineForm(hint: '내일의 일기 제목'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일 있어야 할 일'),
      const SizedBox(height: TdSize.s),
      const MultiLineForm(hint: '내일 있어야 할 일을 적어주세요'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일 기대하고 있는 일'),
      ...ModalUtil.widgetFromStringList(wishListData),
      const SizedBox(height: TdSize.s),
      const WishListForm(hint: 'wish list gogo'),
      const SizedBox(height: TdSize.m),
      const TextWidget.body(text: '내일의 기분'),
      const SizedBox(height: TdSize.s),
      SingleLineForm(hint: '내일의 기분을 미리 예측해 보세요.'),
      const SizedBox(height: TdSize.m),
      SubmitButtonWidget(text: '작성 완료'),
    ];
    return ModalUtil.barModalWithListItems(context, listItems, '내일의 일기');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
