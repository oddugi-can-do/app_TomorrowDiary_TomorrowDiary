import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/views/views.dart';

class DrawerSideMenu extends StatefulWidget {
  final double menuWidth;

  DrawerSideMenu(this.menuWidth, {Key? key}) : super(key: key);

  @override
  State<DrawerSideMenu> createState() => _DrawerSideMenuState();
}

class _DrawerSideMenuState extends State<DrawerSideMenu> {
  File? image;

  UserController uc = Get.find();

  GalleryController gc = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.menuWidth,
      child: Container(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
                child:image == null ?  ClipOval(child: Image.network('${gc.todayImages}')): ClipOval(child : Image.file(File(image!.path) , width: 160 , height: 160 , fit: BoxFit.cover))  ,
                // ClipOval(child: Image.network('${gc.todayImages}')),
                radius: 50),
          ),
          Text("${uc.principal.value.username}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 30),
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                uc.logout();
              },
            ),
          ),
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text('MyPage', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(() => MyPageScreen());
              },
            ),
          ),
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                CupertinoIcons.book,
                color: Colors.white,
              ),
              title: Text('Open Source', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(() => OpenSourceScreen());
              },
            ),
          ),
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.image_sharp,
                color: Colors.white,
              ),
              title: Text('Image', style: TextStyle(color: Colors.white)),
              onTap: () async {
                try{
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) {
                  return;
                }

                final imageTemporary = File(image.path);
                setState(() {
                  this.image = imageTemporary;
                });
                }on PlatformException catch (e) {
                  snackBar(msg: "Faild to load image");
                }
                
                // if(await _checkPermission(context)) {
                //   Get.to(GalleryScreen());
                // }
                // Get.to(GalleryScreen());
              },
            ),
          ),
        ]),
      ),
    );
  }
}
