// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'views/views.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyDiaryApp());
}

class MyDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      home: SplashScreen(),
    );

    // // theme: ThemeData(
    //   brightness: Brightness.dark,
    //   primaryColor: Colors.black,
    //   // colorScheme: ColorScheme.light(),
    //   accentColor: Colors.white,
    //   snackBarTheme: const SnackBarThemeData(
    //     backgroundColor: TdColor.black,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(10))),
    //     contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
    //   ),
    // ),
  }
}
