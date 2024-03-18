import 'package:flutter/material.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  List<DataMap>? _cancelReasons;

  UserModel? get user => _user;
  List<DataMap>? get cancelReasons => _cancelReasons;

  void initUser(UserModel? user) {
    if (user != _user) _user = user;
    Future.delayed(Duration.zero, notifyListeners);
  }

  set user(UserModel? user) {
    if (user != _user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  set cancelReasons(List<DataMap>? reasons) {
    _cancelReasons = reasons;
    Future.delayed(Duration.zero, notifyListeners);
  }
}
