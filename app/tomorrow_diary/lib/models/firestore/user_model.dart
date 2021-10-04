// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:tomorrow_diary/models/diary_model.dart';
// import 'package:tomorrow_diary/models/models.dart';
// import 'package:tomorrow_diary/utils/firestore_key.dart';

// class UserDataModel {
//   String? username;
//   String? email;
//   String? userKey;
//   Map<String, dynamic> all_data;
//   DocumentReference? reference; //해당 Doc이 어디있는지 참조하는 변수

//   //Firebase에서 오는 JSON데이터 타입을 MAP형태로 받은다음 UserDataModel 클래스의 프로퍼티에 넣는 기능을한다.
//   UserDataModel.fromMap(Map<String, dynamic> map, this.userKey,
//       {this.reference})
//       : username = map[USER_USERNAME],
//         email = map[USER_EMAIL],
//         all_data = map[USER_ALL_DATA];

//   //Firebase의 저장되어있는 각각의 document(snapshot.data())를 가져와서 doc의 키값(snapshot.id)에 해당하는 것을 fromMap에 보내주어
//   // UserDataModel의 프로퍼티에 저장
//   UserDataModel.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data()! as Map<String, dynamic>, snapshot.id,
//             reference: snapshot.reference);

//   static Map<String, dynamic> getCreateUser(String? email, String? username) {
//     Map<String, dynamic> map = Map();
//     map[USER_EMAIL] = email;
//     map[USER_USERNAME] = username;
//     map[USER_ALL_DATA] = {};
//     return map;
//   }

//   static Map<String, dynamic> getCreateDiary(String? title, String? ty, String? tmr, String? surprise, String? date, List<String> wish) {
//     Map<String, dynamic> map = Map();
//     map[USER_ALL_DATA] = {
//       DIARY:{
//       date: {
//         DIARY_TITLE : title,
//         DIARY_TMR : tmr,
//         DIARY_TY : ty,
//         DIARY_SURP: surprise,
//         DIARY_WISH: wish,
//       }
//       }
//     };
//     return map;
//   }

//   // 다이어리 가져오기
//   static Map<String,dynamic> getDiary(BuildContext context) {
//     return Provider.of<UserModelState>(context).userModel.all_data[DIARY];
//   }

//   // 다이어리 타이틀 가져오기
//   static String getDiaryTitle(BuildContext context,String? date) {
//     Map<String,dynamic> diary = getDiary(context);
//     return diary[date][DIARY_TITLE];
//   }

//   static String getDiaryTmr(BuildContext context,String? date) {
//     Map<String,dynamic> diary = getDiary(context);
//     return diary[date][DIARY_TMR];
//   }

//   static String getDiaryTy(BuildContext context,String? date) {
//     Map<String,dynamic> diary = getDiary(context);
//     return diary[date][DIARY_TY];
//   }

//   static String getDiarySurp(BuildContext context,String? date) {
//     Map<String,dynamic> diary = getDiary(context);
//     return diary[date][DIARY_SURP];
//   }

//   static List<dynamic> getDiaryWish(BuildContext context,String? date) {
//     Map<String,dynamic> diary = getDiary(context);
//     return diary[date][DIARY_WISH];
//   }

//   // static Map<String, dynamic> getCreateTodo(
//   //     String? date, List<dynamic> todoList) {}
// }
