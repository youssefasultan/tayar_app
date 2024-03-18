import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<void> logout();
  Future<void> saveUser({required UserModel user});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> logout() async {
    try {
      final prefs = _prefs;
      await prefs.clear();
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> saveUser({required UserModel user}) async {
    try {
      final prefs = _prefs;

      final userData = user.copyWith(isInitial: false);

      await prefs.setString(loggedUserKey, userData.toJson());
      await prefs.setBool(logStatusKey, false);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
