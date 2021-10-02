import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomorrow_diary/controllers/transformer.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/firestore_key.dart';
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

class UserNetworkRepo with Transformer {
  // Register할 때 FirebaseAuth에서 만든 사용자의 uid를 userKey로 받아와 email과 username을 해당 uid의 document에 저장
  Future<void> createUser(
      {String? userKey, String? email, String? username}) async {
    // 해당 Doc위치를 가져옴
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COL_USER).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(UserDataModel.getCreateUser(email, username));
    }
  }

  Future<void> createDiary({String? userKey,String? title, String? ty, String? tmr, String? surprise,List<String>? wish}) async{
    final DocumentReference diaryRef = FirebaseFirestore.instance.collection(COL_USER).doc(userKey);

    DocumentSnapshot snapshot = await diaryRef.get();
    return diaryRef.update(UserDataModel.getCreateDiary(title, ty, tmr, surprise,'2021-10-02',wish!));
  }
  




  Stream<UserDataModel> getUser(String? userKey) {
    return FirebaseFirestore.instance
        .collection(COL_USER)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }

  // Stream<UserDataModel> getDiary(String? userKey) {
  //   return FirebaseFirestore.instance. collection(COL_USER).doc(userKey).snapshots().transform(toDiary);
  // }

  // void getTodo(String? userKey) {
  //   FirebaseFirestore.instance
  //       .collection(COL_USER)
  //       .doc(userKey)
  //       .get()
  //       .then((docSnapshot) => print(docSnapshot.data()));
  // }

  Future<void> sendData() {
    return FirebaseFirestore.instance.collection(COL_USER).doc('1234').set({
      'email' : 'testuser2@gmail.com',
      'username' : 'testuser2',
      'all_data' : {
        '2021-10-02' : {
          'diary' : {
            'title' : '오늘의 일기',
            'tmr' : '내일은 당직 24시간이다 내일이 빨리 지나가야하는데 에휴',
            'ty' : '오늘은 개발하는 날',
            'wish' : ['포상휴가 나왔으면' , '점호 안했으면' , '저녁점호안했으면']
          },
          'todo' : { 
            'item1' : {
              'start' : '12:20',
              'end'   : '13:10',
              'data'  : '노래방 가기'
            },
            'item2' : {
              'start' : '13:20',
              'end' : '14:10',
              'data' : '밥먹기'
            }
          }
        }
      }
    });
  }


  void getData() {
    FirebaseFirestore.instance.collection(COL_USER).doc('1234').get()
    .then((documentSnapshot) => print(documentSnapshot.data()!['all_data']['2021-10-02']['diary']['wish'])); //데이터 가져오기
  }
}

UserNetworkRepo userRepo = UserNetworkRepo();
