import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class GalleryScreen extends StatefulWidget {
  GalleryController gc = Get.find();
  GalleryScreen({Key? key}) : super(key: key);
  @override
  _GalleryScreenState createState() {
    return _GalleryScreenState();
  }
}

//환경이 안되서 테스트를 못함으로 인해 pcisum으로 대체 ㅠㅠ

class _GalleryScreenState extends State<GalleryScreen> {
  GalleryController gc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        backgroundColor: Colors.black87,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          30,
          (index) => InkWell(
              child: Image.network(
                'https://picsum.photos/id/${index}/150/150',
                fit: BoxFit.cover,
              ),
              onTap: () async {
                String currentImage =
                    'https://picsum.photos/id/${index}/500/500';
                Get.to(ShareScreen(imageFile: currentImage));
              }),
        ),
      ),
    );
  }
}
