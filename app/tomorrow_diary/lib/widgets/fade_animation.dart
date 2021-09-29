import 'package:flutter/material.dart';
import 'package:tomorrow_diary/constant/duration.dart';
import 'package:tomorrow_diary/views/views.dart';


// Animimation을 사용하기 위한 클래스
class FadeAnimation extends StatefulWidget {
  final SelectedForm? selectedIndex;
  final List<Widget>? forms;
  const FadeAnimation({this.selectedIndex,this.forms});

  @override
  _FadeAniMationState createState() => _FadeAniMationState();
}

class _FadeAniMationState extends State<FadeAnimation> with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  
  @override
  void initState() {
    if(_animationController == null) {
      _animationController = AnimationController(vsync: this, duration: duration);
    }
    _animationController!.forward();
    super.initState();
  }

  //현재 상태와 이전 상태를 비교 
  @override
  void didUpdateWidget(covariant FadeAnimation oldWidget) {
    if(widget.selectedIndex != oldWidget.selectedIndex){
      _animationController!.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return  FadeTransition(
              opacity: _animationController!,
              child: IndexedStack(
                children: widget.forms!,
                index: widget.selectedIndex!.index,
              ),
            );
  }
}