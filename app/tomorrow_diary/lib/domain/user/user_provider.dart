import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomorrow_diary/models/models.dart';

class UserProvider {
  final _col = "Users";

  Future<QuerySnapshot> getUserDataFb(String uid) => FirebaseFirestore.instance
      .collection(_col)
      .where("uid", isEqualTo: "$uid")
      .get();

  Future<DocumentReference> sendUserDataFb(UserModel newUser) =>
      FirebaseFirestore.instance.collection(_col).add(newUser.toJson());

}