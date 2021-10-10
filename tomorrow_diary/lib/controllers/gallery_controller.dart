import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class GalleryController extends GetxController {
  final todayImages =
      'https://avatars.githubusercontent.com/u/19565940?v=4'.obs;
  final image = File('').obs;
  final initImage  = false.obs;


  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/{$name}');
    return File(imagePath).copy(image.path);
  }

  void openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }

      // final imageTemporary = File(image.path);
      final imagePath = await saveImage(image.path);
      this.image.value = imagePath;
      this.initImage.value = true;
    } on PlatformException catch (e) {
      snackBar(msg: "Faild to load Camera");
    }
  }

  void getGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imagePath = await saveImage(image.path);
      this.image.value = imagePath;
      this.initImage.value = true;
    } on PlatformException catch (e) {
      snackBar(msg: "Faild to load image");
    }
  }
}