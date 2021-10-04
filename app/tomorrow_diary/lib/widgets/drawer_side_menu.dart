import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class DrawerSideMenu extends StatelessWidget {
  UserController uc = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                uc.logout();
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {
                  // Get.to(CameraScreen());
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
