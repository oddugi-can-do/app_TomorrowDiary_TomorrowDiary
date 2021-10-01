import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

enum WishListState { checked, unchecked }

class WishListWidget extends StatefulWidget {
  WishListState wishListState;
  String text;
  WishListWidget(
      {Key? key, this.wishListState = WishListState.unchecked, this.text = ''})
      : super(key: key);

  @override
  _WishListWidgetState createState() => _WishListWidgetState();
}

class _WishListWidgetState extends State<WishListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          switch (widget.wishListState) {
            case WishListState.checked:
              widget.wishListState = WishListState.unchecked;
              break;
            case WishListState.unchecked:
              widget.wishListState = WishListState.checked;
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: TdColor.darkGray,
            borderRadius: BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            widget.wishListState == WishListState.unchecked
                ? Icon(Icons.circle_outlined, size: TdSize.m)
                : Icon(Icons.circle, size: TdSize.m),
            SizedBox(width: TdSize.xs),
            TextWidget.body(text: widget.text),
          ],
        ),
      ),
    );
    // return ElevatedButton(
    //   onPressed: () {},
    //   child: TextWidget.body(text: text),
    //   style: ElevatedButton.styleFrom(
    //     shadowColor: Colors.transparent,
    //     minimumSize: Size(TdSize.xxl * 2, TdSize.xxl * 2),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(TdSize.radiusM),
    //     ),
    //     primary: TdColor.blue,
    //   ),
    // );
  }
}
