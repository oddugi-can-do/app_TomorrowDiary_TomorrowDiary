import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

enum WishListState { checked, unchecked }

class WishWidget extends StatefulWidget {
  WishListState wishListState;
  String text;
  void Function(bool) onTap;
  void Function(bool)? onLongPressed;
  WishWidget(
      {Key? key,
      this.wishListState = WishListState.unchecked,
      this.text = '',
      this.onLongPressed,
      required this.onTap})
      : super(key: key);

  @override
  _WishWidgetState createState() => _WishWidgetState();
}

class _WishWidgetState extends State<WishWidget> {
  var _tapPosition;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _showDeleteMenu,
      onTapDown: _storePosition,
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
                : TdColor.brown,
            borderRadius:
                const BorderRadius.all(Radius.circular(TdSize.radiusM))),
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            widget.wishListState == WishListState.unchecked
                ? const Icon(Icons.circle_outlined, size: TdSize.m)
                : const Icon(Icons.circle, size: TdSize.m),
            const SizedBox(width: TdSize.xs),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget.body(text: widget.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteMenu() {
    if (widget.onLongPressed == null) return;
    print('show delete menu');
    final Size overlaySize =
        Overlay.of(context)!.context.findRenderObject()!.semanticBounds.size;

    print('overlay size defined');
    showMenu(
      elevation: 0,
      color: Colors.transparent,
      context: context,
      items: <PopupMenuEntry<bool>>[DeleteEntry()],
      position: RelativeRect.fromRect(
        _tapPosition & Size(0, 0), // smaller rect, the touch area
        Offset.zero & overlaySize, // Bigger rect, the entire screen
      ),
    ).then<void>((bool? delta) {
      if (delta == null) return;
      setState(() {
        widget.onLongPressed!(delta);
      });
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
