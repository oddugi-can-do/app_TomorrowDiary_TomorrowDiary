import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/user_network_controller.dart';
import 'package:tomorrow_diary/mixins/mixins.dart';
import 'package:tomorrow_diary/models/models.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class ServeWidget extends StatelessWidget with PrintLogMixin {
  final double height;
  final String text;
  final Color color;
  const ServeWidget({Key? key, required this.text, required this.color})
      : height = 100,
        super(key: key);
  // 왼쪽 바는 가로의 0.05%이다.
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    List<dynamic> wishList =  UserDataModel.getDiaryWish(context, '2021-10-02');
    TextEditingController titleController = TextEditingController();
    TextEditingController tmrController = TextEditingController();
    TextEditingController tyController = TextEditingController();
    TextEditingController wishController = TextEditingController();
    TextEditingController surpriseController = TextEditingController();
    return InkWell(
      onTap: () {
        printLog('serve widget tapped');
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: 400,
                  color: TdColor.black,
                  child: Column(
                    children: [
                      Text(
                          UserDataModel.getDiaryTitle(context, '2021-10-02'),
                        ),
                        Text(
                          UserDataModel.getDiaryTy(context, '2021-10-02'),
                        ),
                        Text(
                          UserDataModel.getDiaryTmr(context, '2021-10-02'),
                        ),
                        Text(
                          UserDataModel.getDiarySurp(context, '2021-10-02'),
                        ),
                      ...wishList.map((e) => Text(e)),
                        /*
                        List<Widget>.generate(items.length, (idx) {
          return Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.all(8),
            child: Text(
                items[idx],
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
            ),
          );
        }).toList()
                        */
                      // ...wishList.map((e) => Text(e)),
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.cancel_sharp),
                          color: TdColor.blue,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      
                      CustomTextFormField(
                        controller: titleController,hint: "Title",
                      ),
                      CustomTextFormField(controller: tmrController , hint: "tomorrow do" , validation: null,),
                      CustomTextFormField(controller: tyController , hint : "today do", validation: null),
                      // CustomTextFormField(controller: wishController),
                      CustomTextFormField(controller: surpriseController, hint : "surprise", validation: null),
                      ElevatedButton(onPressed: () {
                        _sendData(uid:currentUid,title:titleController.text,tmr : tmrController.text, ty: tyController.text, surprise: surpriseController.text, wish: ['휴가가기', '휴가받기']);
                      }, child: Text("SendData")),
                    ]
                  ),
                  );
            });
      },
      child: Stack(
        children: [
          Container(
            // width: size.width,
            height: height,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: TdColor.gray,
                borderRadius: BorderRadius.circular(TdSize.radiusM),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 300 * 0.05,
              height: 100,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(TdSize.radiusM),
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: 300 * 0.05 * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget.body(text: text),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _sendData( {String? uid,String? title, String? ty, String? tmr, String? surprise, List<String>? wish}) async{
    return await UserNetworkRepo().createDiary(userKey: uid, title: title, ty: ty,tmr : tmr, surprise: surprise, wish: wish);
  }
}
