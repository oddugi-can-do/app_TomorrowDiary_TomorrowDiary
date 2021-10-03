import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomorrow_diary/controllers/transformer.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/firestore_key.dart';

class UserNetworkRepo with Transformer {
  // Register할 때 FirebaseAuth에서 만든 사용자의 uid를 userKey로 받아와 email과 username을 해당 uid의 document에 저장
  // Signin에서 사용
  Future<void> createUser(
      {String? userKey, String? email, String? username}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COL_USER).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(
        UserDataModel.userToMap(email, username),
      );
    }
  }

  // 다이어리를 생성할 때와 업데이트 할 때 사용
  Future<void> createDiary(
      {String? userKey,
      String? title,
      String? ty,
      String? surprise,
      List<String>? wish}) async {
    final DocumentReference diaryRef =
        FirebaseFirestore.instance.collection(COL_USER).doc(userKey);

    DocumentSnapshot snapshot = await diaryRef.get();
    return diaryRef.update(
      TodayDiary.tyDiaryToMap(
        TodayDiary(
          title: title,
          ty: ty,
          surprise: surprise,
          date: '2021-10-02',
          wishList: wish!,
        ),
      ),
    );
  }

  // main.dart에서 스트림 형태로 계속 데이터를 파이어베이스에서 갖고와 갱신시켜준다.
  Stream<UserDataModel> getUserAllData(String? userKey) {
    return FirebaseFirestore.instance
        .collection(COL_USER)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }

}

UserNetworkRepo userRepo = UserNetworkRepo();





/*
UserNetworkRepo는 데이터를 파이어베이스에 보내고 가져오는 것을 담당함 ^^
*/

// Firebase로 데이터 보내는 예시
// return FirebaseFirestore.instance.collection('Users').doc('123').set({
//   'username' : "Kim",
//   'email' : "joon951019@gmail.com"
// });
// Firebase로 데이터를 갖고오는 예시
// FirebaseFirestore.instance.collection('Users').doc('123').get().then((docSnapshot) => print(docSnapshot.data()));
