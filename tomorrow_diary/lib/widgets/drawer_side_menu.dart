import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  void initState() {
    Get.put(UserController());
    Get.put(GalleryController());
    super.initState();
  }

  UserController uc = Get.find();
  GalleryController gc = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.menuWidth,
      child: Container(
        child: ListView(children: [
          _profile(),
          SizedBox(height: 10),
          Text("${uc.principal.value.username}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(height: 30),
          Obx(
            () => gc.initImage != true
                ? Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: TdColor.brown, width: 1)),
                    color: Colors.transparent,
                    child: ListTile(
                      // leading: Icon(Icons.emoji_emotions_sharp),
                      title: Text(
                        "오늘의 기분",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "사용자의 개인정보를 위해 사진은 따로 저장을 안합니다. 안심하고 올려주시기 바랍니다.",
                          style: TextStyle(
                            color: Colors.white30,
                          )),
                      isThreeLine: true,
                    ),
                  )
                : Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: TdColor.brown, width: 1)),
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        getEmoDescript(gc.emotion[0]['Type']),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("더 많은 감정을 수치로 알고 싶으면 클릭하세요",
                          style: TextStyle(color: Colors.white30)),
                      isThreeLine: true,
                      onTap: () {
                        Get.to(AnalysisEmoScreen());
                      },
                    ),
                  ),
          ),
          Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: TdColor.brown, width: 1)),
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
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: TdColor.brown, width: 1)
                ),
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
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: TdColor.brown, width: 1)),
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
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            // Android에서 사용
            child: Obx(
              () => CircleAvatar(
                radius: 82.0,
                backgroundColor: TdColor.brown,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: gc.initImage.value == false
                      ? AssetImage('assets/tomorrow.gif')
                      : FileImage(File(gc.image.value.path)) as ImageProvider,
                ),
              ),
            ),

            //웹에서 사용
            //  child: GetBuilder<GalleryController>(

            //    builder:(controller) {  return CircleAvatar(
            //     radius: 80.0,
            //     backgroundImage: gc.initImage.value == false  ?  AssetImage('assets/book.gif') : MemoryImage(gc.imageWebBytes!) as ImageProvider,
            //             );
            //    }
            //  ),
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
        children: [
          Text("Choose Profile Photo",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: gc.openCamera,
                icon: Icon(Icons.camera_alt_rounded, color:Colors.white),
                iconSize: 30,
              ),
              //Android
              IconButton(
                onPressed: gc.getGallery,
                icon: Icon(Icons.image, color: Colors.white),
                iconSize: 30,
              ),
              //Web
              // IconButton(onPressed: gc.getPictureWeb , icon: Icon(Icons.image), iconSize: 30,),
            ],
          )
        ],
      ),
    );
  }
}
