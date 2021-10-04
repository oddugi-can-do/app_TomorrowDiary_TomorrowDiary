// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/bindings.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyDiaryApp());
}

class MyDiaryApp extends StatelessWidget {
  Widget build(BuildContext context){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        home: AuthScreen(),
      );
  }
}





  // FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  // Widget? _currentScreen;

  // @override
  // Widget build(BuildContext context) {
  //   _firebaseAuthState.watchAuthChange();

  //   // return MultiProvider(
  //   //   providers: [
  //   //     ChangeNotifierProvider<FirebaseAuthState>.value(
  //   //       value: _firebaseAuthState, //원래 기존에 있던 것을 사용
  //   //     ),
  //   //     ChangeNotifierProvider<UserModelState>(create: (_) => UserModelState()),
  //   //   ],
  //   //   child: 
  //    return GetMaterialApp(
  //       theme: ThemeData(
  //         brightness: Brightness.dark,
  //         primaryColor: Colors.black,
  //         accentColor: Colors.white,
  //         snackBarTheme: SnackBarThemeData(
  //           backgroundColor: TdColor.black,
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(10))),
  //           contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
  //         ),
  //       ),
  //       // home: Consumer<FirebaseAuthState>
  //       home: GetBuilder<FirebaseAuthState>(
  //         // builder: (context, firebaseAuthState, child) 
  //           builder: (firebaseAuthState){
  //           switch (firebaseAuthState.firebaseAuthStatus) {
  //             case FirebaseAuthStatus.signout:
  //               // _clearUserModel(context);
  //               _currentScreen = AuthScreen();
  //               break;
  //             case FirebaseAuthStatus.signin:
  //               // UserNetworkRepo().getUser(_firebaseAuthState.firebaseUser.uid).listen((userModel) { 
  //               //   Provider.of<UserModelState>(context,listen: false).userModel= userModel;
  //               // });
  //               // _initUserModel(context);
  //               _currentScreen = HomeScreen();
  //               break;
  //           }
  //           return AnimatedSwitcher(
  //             duration: duration,
  //             child: _currentScreen,
  //           );
  //         },
  //       ),
  //     );
  // }

  // void _initUserModel(BuildContext context) {
  //   UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
  //   userModelState.currentSubscription =UserNetworkRepo()
  //       .getUser(_firebaseAuthState.firebaseUser.uid)
  //       .listen((userModel) {
  //         userModelState.userModel=userModel;
  //   });
  // }

  // void _clearUserModel(BuildContext context) {
  //   UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
  //   userModelState.clear();
  // }
// }
