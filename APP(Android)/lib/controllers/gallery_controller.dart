import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/connect_aws.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:http/http.dart' as http; //웹 땜시
// import 'package:image_picker_web/image_picker_web.dart'; //웹 땜시

class GalleryController extends GetxController {
  final image = File('').obs;
  final initImage  = false.obs;
  final emotion = [].obs;
  Uint8List? imageWebBytes;
  Uint8List? imageBytesOnAndr;


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
      imageBytesOnAndr = await image.readAsBytes();
      final body = await getRekogData(imageBytesOnAndr!);
      if(body == "error") {
        snackBar(msg: "사진을 인식하지 못하였습니다. 최대한 정면 얼굴 사진을 사용하여 주세요.");
      }else{
        EmotionModel tempEmotion = EmotionModel();
        tempEmotion.updateEmotion(body);
        this.emotion.value = tempEmotion.emotion;
        final imagePath = await saveImage(image.path);
        this.image.value = imagePath;
        this.initImage.value = true;
      }
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
      imageBytesOnAndr = await image.readAsBytes();
      if(imageBytesOnAndr == null) {
        snackBar(msg: "다른 이미지를 사용해주시겠습니까?");
        return;
      }
      
      final body = await getRekogData(imageBytesOnAndr!);
      if(body == "error") {
        snackBar(msg: "사진을 인식하지 못하였습니다. 최대한 정면 얼굴 사진을 사용하여 주세요.");
      }
      else{
        EmotionModel tempEmotion = EmotionModel();
        tempEmotion.updateEmotion(body);
        this.emotion.value = tempEmotion.emotion;
        final imagePath = await saveImage(image.path);
        this.image.value = imagePath;
        this.initImage.value = true;
        update();
      }
    } on PlatformException catch (e) {
      snackBar(msg: "Faild to load image");
    }
  }


  // 웹에서만 가능

  // void getPictureWeb() async {
  //   try {
  //      Uint8List bytesFromPicker =
  //       await ImagePickerWeb.getImage(outputType: ImageType.bytes) as Uint8List;
  //     if(bytesFromPicker == null) {
  //       snackBar(msg: "사진을 다시 올려주세요. jpg와 png만 됩니다.");
  //     }
  //     this.imageWebBytes=bytesFromPicker;
      
  //     final body = await getRekogData(bytesFromPicker);
  //     EmotionModel tempEmotion  = EmotionModel();
  //     tempEmotion.updateEmotion(body);
  //     this.emotion.value = tempEmotion.emotion;
  //     this.initImage.value = true;
  //     update();

  //   }on PlatformException catch (e) {
  //     snackBar(msg: "Faild to load image");
  //   }
  // }

  Future<String> getRekogData(Uint8List bytes) async{
    String base64Image = changeToBytes(bytes);
    http.Response res = await httpPostImg(base64Image);
    if(res.statusCode != 200) {
      return "error";
    }
    final body = res.body;
    return body;
  }

   String changeToBytes(Uint8List bytesFromPicker) {
    String base64Image = base64Encode(bytesFromPicker);
    return base64Image;
  }

  
}