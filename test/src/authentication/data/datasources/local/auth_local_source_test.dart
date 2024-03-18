import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tayar_app/src/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';

void main() {
  late SharedPreferences pref;
  late AuthLocalDataSourceImpl localDataSource;
  const tUser = UserModel.empty();
  
  setUp(() async {
    SharedPreferences.setMockInitialValues(
      {
        'user': tUser.toJson(),
        'status': true,
      },
    );
    pref = await SharedPreferences.getInstance();
    localDataSource = AuthLocalDataSourceImpl(pref);
    WidgetsFlutterBinding.ensureInitialized();
  });
  group('save user', () {
    test(
        'should return successfully when'
        ' [AuthLocalDataSource.SAveUser] is called', () async {
      await pref.remove('user');
      final newtUser = tUser.copyWith(isInitial: false);
      await localDataSource.saveUser(user: tUser);

      expect(pref.getString('user'), equals(newtUser.toJson()));
      expect(pref.getBool('status'), equals(false));
    });
  });

  group('user exist', () {
    test(
        'pref should be empty when'
        ' [AuthLocalDataSource.logout] is called', () async {
      await localDataSource.logout();

      expect(pref.containsKey('user'), equals(false));
      expect(pref.containsKey('status'), equals(false));
    });
  });
}
