// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/constant/duration.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/routes.dart';

import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyDiaryApp());
}

class MyDiaryApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget? _currentScreen;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: RootScreen.pageId,
    //   getPages: appPages,
    // );
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white,
        ),
        home: Consumer<FirebaseAuthState>(
          builder: (context, firebaseAuthState, child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _currentScreen = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _currentScreen = HomeScreen();
                break;
            }

            return AnimatedSwitcher(
              duration: duration,
              child: _currentScreen,
            );
          },
        ),
      ),
    );
  }
}
