import 'package:flutter/material.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

enum WishListState { checked, unchecked }

class WishWidget extends StatefulWidget {
  WishListState wishListState;
  String text;
  void Function(bool) onTap;
  WishWidget(
      {Key? key,
      this.wishListState = WishListState.unchecked,
      this.text = '',
      required this.onTap})
      : super(key: key);

  @override
  _WishWidgetState createState() => _WishWidgetState();
}

class _WishWidgetState extends State<WishWidget> {
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
              widget.onTap(false);
              break;
            case WishListState.unchecked:
              widget.wishListState = WishListState.checked;
              widget.onTap;
              widget.onTap(true);
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
