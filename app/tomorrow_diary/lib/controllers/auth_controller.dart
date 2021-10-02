import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tomorrow_diary/controllers/user_network_controller.dart';
import 'package:tomorrow_diary/utils/utils.dart';

enum FirebaseAuthStatus {
  signout,
  progress,
  signin,
}

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User? _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  User get firebaseUser => _firebaseUser!;

// Stream을 받아옴(상태가 바뀔때마다)
  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

//유저 등록
  void registerUser(BuildContext context,
      {@required String? email,
      @required String? password,
      @required String? username}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .catchError((e) {
      String _msg = '';
      switch (e.code) {
        case 'weak-password':
          _msg = "비밀번호가 취약합니다. 다시 입력해주세요";
          break;
        case 'email-already-in-use':
          _msg = "이미 계정이 있습니다. 다른 이메일을 사용하세요";
          break;
        case 'invalid-email':
          _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
          break;
      }

      SnackBar snackbar = SnackBar(
        content: Text(_msg),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });
    _firebaseUser = userCredential.user;

    if (_firebaseUser == null) {
      SnackBar snackbar = SnackBar(
        content: Text("Please try again"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      await UserNetworkRepo().createUser(
          userKey: _firebaseUser!.uid, email: email, username: username);
    }
    notifyListeners();
  }

//유저 로그인
  void login(BuildContext context,
      {@required String? email, @required String? password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .catchError((e) {
      String? _msg = '';
      switch (e.code) {
        case 'invalid-email':
          _msg = "이메일 형식이 아닙니다. 다시 입력해주세요";
          break;
        case 'user-not-found':
          _msg = "해당되는 유저가 없습니다.";
          break;
        case 'wrong-password':
          _msg = "패스워드가 틀립니다. 다시 입력해주세요";
      }
      SnackBar snackbar = SnackBar(
        content: Text(_msg),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });

    _firebaseUser = userCredential.user;

    if (_firebaseUser == null) {
      SnackBar snackbar = SnackBar(
        content: Text("Please try again"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } 
    notifyListeners();
  }

//로그아웃
  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }

    notifyListeners();
  }

//로그인상태를 검사 
  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
  }
}
