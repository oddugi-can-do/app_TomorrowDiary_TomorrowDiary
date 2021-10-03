import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomorrow_diary/models/user_model.dart';

class Transformer {
  final toUser = StreamTransformer<DocumentSnapshot<Map<String,dynamic>>,UserDataModel>.fromHandlers(
    handleData: (snapshot,sink) async {
      sink.add(UserDataModel.fromSnapshot(snapshot));
    },
  );

  final toDiary = StreamTransformer<DocumentSnapshot<Map<String,dynamic>>,UserDataModel>.fromHandlers(
    handleData: (snapshot,sink) async{
      sink.add(UserDataModel.fromSnapshot(snapshot));
    }
  );
}