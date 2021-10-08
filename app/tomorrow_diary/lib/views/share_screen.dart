import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/controllers/gallery_controller.dart';
import 'package:http/http.dart' as http;

class ShareScreen extends StatelessWidget {
  final String? imageFile;
  const ShareScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GalleryController gc = Get.put(GalleryController());
    UserController uc = Get.find();
    String? uid = uc.principal.value.uid;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Image", textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: ()  {

                gc.todayImages.value = imageFile!;
                // final file = await getFileFromNetworkImage(imageFile!);
                // gc.uploadImage(file, uid);
              },
              child: Text("Select",
                  textScaleFactor: 1.4, style: TextStyle(color: Colors.blue)),
            )
          ],
        ),
        body: Container(
          width: width,
          height: height,
          child: Container(
            alignment: Alignment.center,
            child: Image.network(
              imageFile!,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ));
  }

  // Future<File> getFileFromNetworkImage(String imageUrl) async {
  //   var response = await http.get(Uri.parse(imageUrl));
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   File file = File('${fileName}.png');
  //   file.writeAsBytes(response.bodyBytes);
  //   return file;
  // }
}
