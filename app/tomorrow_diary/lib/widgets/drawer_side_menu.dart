import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class DrawerSideMenu extends StatelessWidget {
  UserController uc = Get.find();
  GalleryController gc = Get.find();
  final double menuWidth;

  DrawerSideMenu(this.menuWidth, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: menuWidth,
      child: Container(
        child: ListView(children: [
          CircleAvatar(
            child: ClipOval(
              child: Image.network('${gc.todayImages}')
            ),
            radius: 50
          ),
          Text("${uc.principal.value.username}", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height:30),
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
                // if(await _checkPermission(context)) {
                //   Get.to(GalleryScreen());
                // }
                Get.to(GalleryScreen());
              },
            ),
          ),
        ]),
      ),
    );
  }

  // 핸드폰 이미지에 대한 권한 허용 체크
  // Future<bool> _checkPermission(BuildContext context) async {
  //     Map<Permission,PermissionStatus> status= await [Permission.storage, Permission.photos].request();
  //     bool permitted = true;

  //     status.forEach((permission, status) {
  //       if(!status.isGranted){
  //         permitted = false;
  //       }
  //     });
  //     return permitted;
  //   }
}
