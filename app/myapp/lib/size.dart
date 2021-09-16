import 'package:flutter/widgets.dart';

class TDSize {
  /*
  static const xxs = 0.01;
  static const xs = 0.02;
  static const s = 0.03;
  static const m = 0.05;
  static const l = 0.08;
  static const xl = 0.1;
  static const xxl = 0.2;
  static const xxxl = 0.3;
  */
  final BoxConstraints constraints;

  double max = 0.0;

  TDSize(this.constraints) : max = constraints.maxHeight;

  TDSize.withHeight(this.constraints) : max = constraints.maxHeight;

  TDSize.withWidth(this.constraints) : max = constraints.maxWidth;

  double withSize(SizeList size) {
    switch (size) {
      case SizeList.xxs:
        return max * 0.01;
      case SizeList.xs:
        return max * 0.02;
      case SizeList.s:
        return max * 0.03;
      case SizeList.m:
        return max * 0.05;
      case SizeList.l:
        return max * 0.08;
      case SizeList.xl:
        return max * 0.1;
      case SizeList.xxl:
        return max * 0.2;
      case SizeList.xxxl:
        return max * 0.3;
    }
  }
}

enum SizeList { xxs, xs, s, m, l, xl, xxl, xxxl }
/*
usage:
import 'size.dart';
LayoutBuilder(
  builder: (context, constraints) {
    return MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: Size(constraints.maxWidth * 0.8, constraints.maxHeight * TDSize.m),
            textStyle: TextStyle(fontSize: constraints.maxHeight * TDSize.xs),
          ),
        ),
      ),
    );
  },
)
*/