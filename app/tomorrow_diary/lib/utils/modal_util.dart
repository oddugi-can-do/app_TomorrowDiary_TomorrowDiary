import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

import 'utils.dart';

class ModalUtil {
  static List<Widget> tyWishWidgetFromStringList(List<Wish>? _listData) {
    DiaryController d = Get.find();

    List<Widget> _list = [];
    if (_listData != null) {
      for (var i = 0; i < _listData.length; i++) {
        _list.add(const SizedBox(height: TdSize.s));
        _list.add(WishWidget(
          text: _listData[i].wish ?? '',
          wishListState: _listData[i].checked ?? false
              ? WishListState.checked
              : WishListState.unchecked,
          onTap: (checked) {
            d.allData.value.tyDiary?.tyWish![i].checked = checked;
          },
        ));
      }
    }
    return _list;
  }

  static List<Widget> tmrWishWidgetFromStringList(List<Wish>? _listData) {
    DiaryController d = Get.find();

    List<Widget> _list = [];

    if (_listData != null) {
      for (var i = 0; i < _listData.length; i++) {
        _list.add(const SizedBox(height: TdSize.s));
        _list.add(WishWidget(
          text: _listData[i].wish ?? '',
          wishListState: _listData[i].checked ?? false
              ? WishListState.checked
              : WishListState.unchecked,
          onTap: (checked) {
            d.allData.value.tmrDiary?.tmrWish![i].checked = checked;
          },
        ));
      }
    }
    _list.add(const SizedBox(height: TdSize.s));
    _list.add(WishListForm(hint: '내일 무엇을 하면 좋을까요?'));
    return _list;
  }

  static Future<dynamic> barModalWithListItems(
      BuildContext context, List<Widget> listItems, String title) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => Ink(
        color: TdColor.deepGray,
        child: NestedScrollView(
          controller: ScrollController(),
          physics: const ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool isInnerBoxScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                        child: TextWidget.body(text: title),
                      ),
                    ),
                  )
                ]),
              ),
            ];
          },
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: TdSize.m, horizontal: TdSize.xl),
            physics: AlwaysScrollableScrollPhysics(),
            // 이 physics를 추가 안하면 listview로 화면이 가득 차지 않을 때 버그가 남.
            controller: PrimaryScrollController.of(context),
            itemBuilder: (context, index) => listItems[index],
            itemCount: listItems.length,
          ),
        ),
      ),
    );
  }
}
