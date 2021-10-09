import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomorrow_diary/domain/user/user_provider.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class UserRepo {
  UserProvider _userProvider = UserProvider();

  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<UserModel?> login(
      {@required String? email, @required String? password}) async {
    UserCredential? user;
    String _msg = '';
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .catchError((e) {
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
      });
    } catch (e) {
      snackBar(msg: _msg);
    }

    //해당 유저가 있으면 해당 유저 uid에 해당하는 정보를 가져옴
    if (user != null) {
      QuerySnapshot querySnapshot =
          await _userProvider.getUserDataFb(user.user!.uid);

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.length > 0) {
        UserModel principal = UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return principal;
      }
    }

    return UserModel();
  }

  Future<UserModel> join(String email, String password, String username) async {
    UserCredential? user;

    String _msg = '';
    try {
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((e) {
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
      });
    } catch (error) {
      snackBar(msg: _msg);
    }

    if (user != null) {
      UserModel principal =
          UserModel(email: '${user.user!.email}', uid: '${user.user!.uid}' , username: '${username}');
      await _userProvider.sendUserDataFb(principal,user.user!.uid);
      return principal;
    } else {
      return UserModel();
    }
  }

// 구글과 페이스북 설정을 해야하는데 설정에 문제가 있어 못하고 있음

  Future<UserCredential> googleSiginIn() async {
    //구글에 로그인
    final googleAuth = await GoogleSignIn().signIn();
    //로그인된 정보를 가져옴
    final googleUser = await googleAuth!.authentication;
    //가져온 정보로 로그인할 수 있게 만들어줌(토큰)
    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleUser.accessToken,
      idToken: googleUser.idToken,
    );
    //로그인함
    final user =
        await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);
    return user;
  }
}
