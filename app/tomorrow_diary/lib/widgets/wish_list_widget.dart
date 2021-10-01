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
            color: widget.wishListState == WishListState.unchecked
                ? TdColor.darkGray
                : TdColor.purple,
            borderRadius:
                const BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            widget.wishListState == WishListState.unchecked
                ? const Icon(Icons.circle_outlined, size: TdSize.m)
                : const Icon(Icons.circle, size: TdSize.m),
            const SizedBox(width: TdSize.xs),
            TextWidget.body(text: widget.text),
          ],
        ),
      ),
    );
  }
}
