// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:tomorrow_diary/models/emotion_model.dart';

// import 'controllers/controllers.dart';

// class TestWidget extends StatefulWidget {
//   const TestWidget({Key? key}) : super(key: key);

//   @override
//   State<TestWidget> createState() => _TestWidgetState();
// }

// class _TestWidgetState extends State<TestWidget> {
//   EmotionModel e = Get.put(EmotionModel());
//   String? s = 'assets/test.jpg';
//   File? file;
//   Server server=Server();
//   @override
//   Widget build(BuildContext context) {
//     GalleryController gc = Get.put(GalleryController());
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   // server.getReq();
//                 },
//                 child: Text("Get")),
//             ElevatedButton(
//                 onPressed: () {
//                   // server.postReq(s);
//                 },
//                 child: Text("Get")),
//             ElevatedButton(
//                 onPressed: () async {
//                   gc.getPictureWeb();
//                   // print(gc.emotion.value);
//                   // _choose();
//                 },
//                 child: Text("Get"))
//           ],
//         ),
//       ),
//     );
//   }
//   String changeToBytes(Uint8List bytesFromPicker) {
//     String base64Image = base64Encode(bytesFromPicker);
//     return base64Image;
//   }
//   void _choose() async {
//       Uint8List bytesFromPicker =
//         await ImagePickerWeb.getImage(outputType: ImageType.bytes) as Uint8List;
//     // File f = await ImagePickerWeb.getImage(outputType: ImageType.file) as File;

//     String base64Image = changeToBytes(bytesFromPicker);

//     http.Response res = await server.httpPost(base64Image);
//     final body = res.body;
//     print(body);
//     // List emotion = jsonDecode(body);
//     // e.updateEmotion(body);
//     // print('------');
//     // print(e.emotion.value);
//     // for(var i in e.emotion.value) {
//     //   print(i['Type']);
//     //   print(i['Confidence']);
//     // }

//     // server.getReq(base64Image);
//     // file = await ImagePicker().pickImage(source: ImageSource.gallery) as File;
//   }

// //  void _upload() {
// //    if (file == null) return;
// //    String base64Image = base64Encode(file!.readAsBytesSync());
// //    String fileName = file!.path.split("/").last;

// //    http.post(Uri.parse("https://axezde37l4.execute-api.ap-northeast-2.amazonaws.com/images/wow"), body: {
// //      "image": base64Image,
// //      "name": fileName,
// //    }).then((res) {
// //      print(res.statusCode);
// //    }).catchError((err) {
// //      print(err);
// //    });
// //  }
//   // Future<Uint8List> _readFileByte(String filePath) async {
//   //   Uri myUri = Uri.parse(filePath);
//   //   File audioFile = new File.fromUri(myUri);
//   //   Uint8List? bytes;
//   //   await audioFile.readAsBytes().then((value) {
//   //   bytes = Uint8List.fromList(value);
//   //   print('reading of bytes is completed');
//   // }).catchError((onError) {
//   //     print('Exception Error while reading audio from path:' +
//   //     onError.toString());
//   // });
//   //   return bytes!;
//   // }

// //   Future<String?> getImage() async {
// //     var image = await ImagePicker()
// //         .pickImage(source: ImageSource.gallery, imageQuality: 50);

// //     if (image != null) {
// //       setState(() {
// //         _image = File(image.path);
// //       });

// //       final bytes = File(image.path).readAsBytesSync();
// //       print(bytes);
// //       String img64 = base64Encode(bytes);
// //       print(img64);
// //       return img64;
// //     }
// //   }
//  }

// class Server {
// Future<http.Response> httpPost(String bytes) {
//   return http.post(
//     Uri.parse('https://vnq0k7mhr0.execute-api.ap-northeast-2.amazonaws.com/tomorrow/image'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     // body: jsonEncode(<String, String>{
//     //   'image': bytes,
//     // }),
//     body:bytes,
//   );
// }

// }
