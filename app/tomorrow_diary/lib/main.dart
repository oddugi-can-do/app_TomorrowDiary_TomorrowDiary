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
      home: LoginScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        // colorScheme: ColorScheme.light(),
        accentColor: Colors.white,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: TdColor.black,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
/*
class MyDiaryApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget? _currentScreen;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();

    return MultiProvider(
      providers: [
        // 로그인 상태 관리 
        ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState, //원래 기존에 있던 것을 사용
        ),

        // 유저데이터가 변경될 떄마다 상태관리하기 위한 프로바이더
        ChangeNotifierProvider<UserModelState>(create: (_) => UserModelState()),
      ],
      child: MaterialApp(

        //테마
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: TdColor.black,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),


        //Home
        home: Consumer<FirebaseAuthState>(
          builder: (context, firebaseAuthState, child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _clearUserModel(context);
                _currentScreen = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _initUserModel(context);
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

  void _initUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.currentSubscription =UserNetworkRepo()
        .getUserAllData(_firebaseAuthState.firebaseUser.uid)
        .listen((userModel) {
          userModelState.userModel=userModel;
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}

*/