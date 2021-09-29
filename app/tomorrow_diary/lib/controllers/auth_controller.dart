
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FirebaseAuthStatus {
  signout,
  progress,
  signin,
}

class FirebaseAuthState extends ChangeNotifier{
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User? _firebaseUser;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;


  void watchAuthChange(){ // Stream을 받아옴(상태가 바뀔때마다)
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser == null){
        return;
      }else if(firebaseUser != _firebaseUser){
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser ({@required String? email,@required String? password}) async{
    UserCredential userCredential= await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
    notifyListeners();
  }


  void login({@required String? email,@required String? password}) async{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
    notifyListeners();
  }

  void signOut(){
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if(_firebaseUser != null){
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }

    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]){
    if(firebaseAuthStatus != null) {
      print(_firebaseAuthStatus);
      _firebaseAuthStatus = firebaseAuthStatus;
    }
    else{
      if(_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      }else{
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
  }



}