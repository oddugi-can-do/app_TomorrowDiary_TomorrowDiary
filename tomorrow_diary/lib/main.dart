// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/utils/snackbar_util.dart';
import 'controllers/controllers.dart';
import 'views/views.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyDiaryApp());
}



class MyDiaryApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FutureBuilder (
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("앱에 오류가 있습니다. 다시 실행시켜 주세요"),
            );
          }
          if(snapshot.hasData == false ){
            return CircularProgressIndicator();
          }

          return GetMaterialApp(
               debugShowCheckedModeBanner: false,
                initialBinding: AppBinding(),
                home: AuthScreen(),
          );
        },
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
