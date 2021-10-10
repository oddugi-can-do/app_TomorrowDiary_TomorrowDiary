import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class DrawerSideMenu extends StatefulWidget {
  final double menuWidth;

  DrawerSideMenu(this.menuWidth, {Key? key}) : super(key: key);

  @override
  State<DrawerSideMenu> createState() => _DrawerSideMenuState();
}

class _DrawerSideMenuState extends State<DrawerSideMenu> {
  UserController uc = Get.find();
  GalleryController gc = Get.find();
  File? f;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.menuWidth,
      child: Container(
        child: ListView(children: [
          _profile(),
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
        ]),
      ),
    );
  }

  Widget _profile() {
    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(context: context, 
              builder: ((builder) => bottomSheet()),);
            },
            child: Obx( () =>CircleAvatar(
              radius: 80.0,
              backgroundImage: gc.initImage.value == false  ?  AssetImage('assets/book.gif') : FileImage(File(gc.image.value.path)) as ImageProvider ,
            ),),
          ),
          Positioned(
            left: 70,
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.camera_alt,
              color: Colors.brown,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      color: Colors.black87,
      width: MediaQuery.of(context).size.width,
    
      child: Column(
        children:[
          Text("Choose Profile Photo", style : TextStyle(color: Colors.white , fontSize: 16)),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: gc.openCamera, icon: Icon(Icons.camera_alt_rounded) , iconSize: 30,),
              IconButton(onPressed: gc.getGallery , icon: Icon(Icons.image), iconSize: 30,),
            ],)
        ],
      ),
    );
  }
}