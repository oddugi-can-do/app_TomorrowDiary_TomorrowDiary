
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'models.dart';

// 유저 상태가 변할 때 새로 유저를 갱신 시켜준다.
class UserModelState extends ChangeNotifier{

  UserDataModel? _userModel;
  StreamSubscription<UserDataModel>? _subscription;
  UserDataModel get userModel => _userModel!;
  

  // 유저가 바뀔 때 notifyListners로 알려줌
  set userModel(UserDataModel userModel){
    _userModel = userModel;
    notifyListeners();
  }


  // 현재 구독상태
  set currentSubscription(StreamSubscription<UserDataModel> sub) => _subscription = sub;

  // 구독을 취소(로그아웃 할때)
  clear() {
    if(_subscription != null){
      _subscription!.cancel();
      _subscription = null;
      _userModel = null;
    }
  }
}