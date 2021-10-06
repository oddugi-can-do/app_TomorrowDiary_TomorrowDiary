// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/controllers/user_network_controller.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/routes.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'models/models.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyDiaryApp());
}

class MyDiaryApp extends StatelessWidget with PrintLogMixin {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      home: AuthScreen(),
      // theme: ThemeData(
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
    );
  }
}