import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/size.dart';

AppBarTheme appTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.black26,
    elevation: 0.0,
    toolbarTextStyle: GoogleFonts.openSans(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black12),
    titleTextStyle: GoogleFonts.openSans(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: GoogleFonts.openSans(fontSize: 18, color: Colors.white),
    headline2: GoogleFonts.openSans(
        fontSize: 16, color: Colors.black45, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.openSans(fontSize: 16, color: Colors.white),
    bodyText2: GoogleFonts.openSans(fontSize: 14, color: Colors.black45),
    subtitle1: GoogleFonts.openSans(fontSize: 15, color: Colors.white),
  );
}

TextButtonThemeData textButtonThemeData(BoxConstraints constraints) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.white54,
      primary: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: Size(constraints.maxWidth * 0.8,
          TDSize.withHeight(constraints).withSize(SizeList.m)),
      textStyle: TextStyle(
          fontSize: TDSize.withHeight(constraints).withSize(SizeList.xs)),
    ),
  );
}

ThemeData theme(BoxConstraints constraints) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    appBarTheme: appTheme(),
    textTheme: textTheme(),
    textButtonTheme: textButtonThemeData(constraints),
  );
}
