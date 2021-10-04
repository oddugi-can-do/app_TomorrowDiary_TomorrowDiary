// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:tomorrow_diary/controllers/user_network_controller.dart';
// import 'package:tomorrow_diary/utils/utils.dart';

import 'package:get/get.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/models/user/user_repo.dart';
import 'package:tomorrow_diary/views/views.dart';

class UserController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final RxBool isLogin = false.obs;
  final principal = UserModel().obs;

  Future<void> logout() async {
    await _userRepo.logout();
    this.principal.value = UserModel(); // 유저 값 초기화
    this.isLogin.value = false;
    Get.offAll(AuthScreen());
  }

  Future<bool> login(String email, String password) async {
    UserModel? principal =
        await _userRepo.login(email: email, password: password);

    if (principal!.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      print(principal);
      Get.to(HomeScreen());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(String email, String password) async {
    UserModel principal = await _userRepo.join(email, password);
    print(principal);
    if (principal.uid != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      Get.to(HomeScreen());
      return true;
    } else {
      return false;
    }
  }
}

// class FirebaseAuthState extends GetxController {
//   final status = Get.put(FirebaseAuthStatus);
//   var _firebaseAuthStatus = status;
//   Rxn<User> _firebaseUser = Rxn<User>();
//   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   get firebaseAuthStatus => _firebaseAuthStatus;
//   get firebaseUser => _firebaseUser.value!.uid;

// //Stream을 받아옴(상태가 바뀔때마다)
//   // void watchAuthChange() {
//   //   _firebaseAuth.authStateChanges().listen((firebaseUser) {
//   //     if (firebaseUser == null && _firebaseUser == null) {
//   //       return;
//   //     } else if (firebaseUser != _firebaseUser) {
//   //       _firebaseUser = firebaseUser;
//   //       changeFirebaseAuthStatus();
//   //     }
//   //   });
//   // }

//   @override
//   void onInit() {
//     _firebaseAuth.authStateChanges().listen((user) { 
//       if(user != null ){
//         _firebaseAuthStatus = FirebaseAuthStatus.signout;
//       }
//     });
//     super.onInit();
//   }

//   void createUser({@required String? email, @required String? password}) async {
//     String _msg = '';
//     try {
//       _firebaseAuth
//           .createUserWithEmailAndPassword(email: email!, password: password!)
//           .catchError((e) {
//         switch (e.code) {
//           case 'weak-password':
//             _msg = "비밀번호가 취약합니다. 다시 입력해주세요";
//             break;
//           case 'email-already-in-use':
//             _msg = "이미 계정이 있습니다. 다른 이메일을 사용하세요";
//             break;
//           case 'invalid-email':
//             _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
//             break;
//         }
//       });
//     } catch (error) {
//       Get.snackbar("Error",_msg, snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   void login({@required String? email, @required String? password}) async{
//     String _msg = '';
//     try{
//       _firebaseAuth
//         .signInWithEmailAndPassword(email: email!, password: password!)
//         .catchError((e) {
//       switch (e.code) {
//         case 'invalid-email':
//           _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
//           break;
//         case 'user-not-found':
//           _msg = "해당되는 유저가 없습니다.";
//           break;
//         case 'wrong-password':
//           _msg = "패스워드가 틀립니다. 다시 입력해주세요";
//         }
//         }
//         );
//     }catch(e){
//       Get.snackbar("Error",_msg, snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   // void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
//   //   if(_firebaseUser.)
//   // }

// //유저 등록
// //   void registerUser(BuildContext context,
// //       {@required String? email,
// //       @required String? password,
// //       @required String? username}) async {
// //     UserCredential userCredential = await _firebaseAuth
// //         .createUserWithEmailAndPassword(email: email!, password: password!)
// //         .catchError((e) {
// //       String _msg = '';
// //       switch (e.code) {
// //         case 'weak-password':
// //           _msg = "비밀번호가 취약합니다. 다시 입력해주세요";
// //           break;
// //         case 'email-already-in-use':
// //           _msg = "이미 계정이 있습니다. 다른 이메일을 사용하세요";
// //           break;
// //         case 'invalid-email':
// //           _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
// //           break;
// //       }

// //       SnackBar snackbar = SnackBar(
// //         content: Text(_msg),
// //         behavior: SnackBarBehavior.floating,
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
// //     });
// //     _firebaseUser = userCredential.user;

// //     if (_firebaseUser == null) {
// //       SnackBar snackbar = SnackBar(
// //         content: Text("Please try again"),
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
// //     } else {
// //       await UserNetworkRepo().createUser(
// //           userKey: _firebaseUser!.uid, email: email, username: username);
// //     }
// //     // notifyListeners();
// //     update();
// //   }

// // //유저 로그인
// //   void login(BuildContext context,
// //       {@required String? email, @required String? password}) async {
// //     UserCredential userCredential = await _firebaseAuth
// //         .signInWithEmailAndPassword(email: email!, password: password!)
// //         .catchError((e) {
// //       String? _msg = '';
// //       switch (e.code) {
// //         case 'invalid-email':
// //           _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
// //           break;
// //         case 'user-not-found':
// //           _msg = "해당되는 유저가 없습니다.";
// //           break;
// //         case 'wrong-password':
// //           _msg = "패스워드가 틀립니다. 다시 입력해주세요";
// //       }
// //       SnackBar snackbar = SnackBar(
// //         content: Text(_msg),
// //         behavior: SnackBarBehavior.floating,
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
// //     });

// //     _firebaseUser = userCredential.user;

// //     if (_firebaseUser == null) {
// //       SnackBar snackbar = SnackBar(
// //         content: Text("Please try again"),
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
// //     }
// //     update();
// //     // notifyListeners();
// //   }

// // //로그아웃
// //   void signOut() {
// //     _firebaseAuthStatus = FirebaseAuthStatus.signout;
// //     if (_firebaseUser != null) {
// //       _firebaseUser = null;
// //       _firebaseAuth.signOut();
// //     }

// //     update();
// //     // notifyListeners();
// //   }

// // //로그인상태를 검사
// //   void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
// //     if (firebaseAuthStatus != null) {
// //       _firebaseAuthStatus = firebaseAuthStatus;
// //     } else {
// //       if (_firebaseUser != null) {
// //         _firebaseAuthStatus = FirebaseAuthStatus.signin;
// //       } else {
// //         _firebaseAuthStatus = FirebaseAuthStatus.signout;
// //       }
// //     }
// //   }
// }


