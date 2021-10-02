import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

import 'utils.dart';

class ModalUtil {
  static List<Widget> widgetFromStringList(List<String> _listData) {
    List<Widget> _list = [];
    for (var element in _listData) {
      _list.add(const SizedBox(height: TdSize.s));
      _list.add(WishListWidget(text: element));
    }
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
