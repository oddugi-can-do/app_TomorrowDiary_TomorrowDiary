// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TestScreen extends StatelessWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String text = "오늘 기분이 너무 좋지만 나쁘기도함 ";
//     return Scaffold(
//       body: Center(
//         child: Container(
//             child: ElevatedButton(
//           child: Text("press"),
//           onPressed: () {
//             awsConnect(text);
//           },
//         )),
//       ),
//     );
//   }

//   Future<String> awsConnect(String text) async {
//     final res = await httpPost(text);
//     num max = 0.0;
//     String emotion = "";
//     Map<String,dynamic> resData = jsonDecode(res.body);

//     resData.forEach((key, value) {
//       if(value > max) {
//         max = value;
//         emotion = key;
//       }
//       });
//     return emotion;
//   }

//   Future<http.Response> httpPost(String bytes) {
//     return http.post(
//       Uri.parse(
//           'https://vnq0k7mhr0.execute-api.ap-northeast-2.amazonaws.com/tomorrow/a2ltYmVvbWpvb25hbmRqZW9uZ2Nob25naW4'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: bytes,
//     );
//   }
// }
