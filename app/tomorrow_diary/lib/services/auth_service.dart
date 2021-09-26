import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';

class AuthService with PrintLogMixin {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;

  // Future<UserCredential> registerUser(String email, String password){}

  // Future<UserCredential> loginUser(String email, String password){}

  Future<void> signOutUser() async {
    await _fireAuth.signOut();
  }
}
