import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomorrow_diary/domain/user/user_provider.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class UserRepo {
  UserProvider _userProvider = UserProvider();

  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> login(
      {@required String? email, @required String? password}) async {
    UserCredential? user;
    String _msg = '이메일과 패스워드를 다시 입력해주시기 바랍니다.';
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

    String _msg = '이름, 이메일, 패스워드를 다시 입력해주시기 바랍니다.';
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

  Future<UserModel?> googleSiginIn() async {
    //구글에 로그인
    final GoogleSignInAccount? googleAuth = await GoogleSignIn().signIn();
    if(googleAuth != null ){
      final GoogleSignInAuthentication googleUser = await googleAuth.authentication;
    //가져온 정보로 로그인할 수 있게 만들어줌(토큰)
    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleUser.accessToken,
      idToken: googleUser.idToken,
    );
   
    //로그인함
    //UserCredential
    final user =
        await  signInCredential(googleAuthCredential);
    if (user != null) {
      QuerySnapshot querySnapshot =
          await _userProvider.getUserDataFb(user.user!.uid);

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.length > 0) {
        UserModel principal = UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return principal;
        }
      else{
        UserModel principal =  UserModel(email: user.user!.email,username:user.user!.displayName, uid: user.user!.uid );
        await _userProvider.sendUserDataFb(principal,user.user!.uid);
        return principal;
        }
      }
    }else{
      Get.back();
      return null;
    }
  }

  Future<UserModel?> facebookSiginIn() async {
    //Facebook Login
    final  accessToken = await FacebookAuth.instance.login();
    if(accessToken.status == LoginStatus.success ) {
      final credential = FacebookAuthProvider.credential(accessToken.accessToken!.token);
      final user = await  signInCredential(credential);
       if (user != null) {
      QuerySnapshot querySnapshot =
          await _userProvider.getUserDataFb(user.user!.uid);

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.length > 0) {
        UserModel principal = UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return principal;
        }
      else{
        UserModel principal =  UserModel(email: user.user!.email,username:user.user!.displayName, uid: user.user!.uid );
        await _userProvider.sendUserDataFb(principal,user.user!.uid);
        return principal;
        }
      }
      UserModel principal = UserModel(email: user!.user!.email,username:user.user!.displayName, uid: user.user!.uid );
      await _userProvider.sendUserDataFb(principal,user.user!.uid);
      return principal;
    }else{
      Get.back();
      return null;
    }
    
  }


  Future<UserCredential?> signInCredential(AuthCredential userCredential) async {
    try{
      final user =
        await FirebaseAuth.instance.signInWithCredential(userCredential);
        return user;
    }on FirebaseAuthException catch(e) {
      if(e.code == 'account-exists-with-different-credential'){
        List<String> userSignMethod = await FirebaseAuth.instance.fetchSignInMethodsForEmail(e.email!);
        Get.back();
        switch(userSignMethod[0]){
          case 'google.com':
          snackBar(msg: "구글 계정이 있습니다. 구글 계정으로 로그인 하십시오");
          break;

          case 'facebook.com':
          snackBar(msg: "페이스북 계정이 있습니다. 페이스북 계정으로 로그인 하십시오");
          break;

          default :
          snackBar(msg: "이메일 계정이 있습니다. 이메일 계정으로 로그인 하십시오");
          break;
        }
      }
    }
    return null;
  }

  Future<UserModel> checkPermission(String uid)  async {

      QuerySnapshot querySnapshot =
          await _userProvider.getUserDataFb(uid);

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

        UserModel principal = UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return principal;
  }
  
}