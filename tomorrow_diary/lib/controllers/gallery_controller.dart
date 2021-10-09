import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final todayImages='https://avatars.githubusercontent.com/u/19565940?v=4'.obs;
  

  Future<TaskSnapshot> uploadImage(File image, String? uid) async {
    final Reference storage =
        await FirebaseStorage.instance.ref().child(_getImagePostKey(uid!));
    final UploadTask upload = storage.putFile(image);
    return upload.whenComplete(() => null);
  }

  String _getImagePostKey(String uid) => 'post/${uid}/test.png';
}
