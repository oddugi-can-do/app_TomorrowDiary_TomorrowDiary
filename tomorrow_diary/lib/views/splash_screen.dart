import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/home_screen.dart';
import 'package:tomorrow_diary/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      Get.to(HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: TdColor.brown,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                Container(
                  child: TextWidget.title(text: '내일 일기'),
                ),
                Expanded(child: SizedBox()),
                Align(
                  child: Text("© Copyright 2021, 내일 일기(Tomorrow Diary)",
                      style: TextStyle(
                        fontSize: screenWidth * (14 / 360),
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0625,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
