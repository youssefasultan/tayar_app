import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tUserModel = UserModel.empty();

  test(
    'should be a subclass of [UserEntity]',
    () => expect(tUserModel, isA<UserEntity>()),
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group(
    'fromMap',
    () {
      test(
        'Should return a valid [UserModel] from the map',
        () {
          // act
          final result = UserModel.fromMap(tMap);

          // assert
          expect(result, isA<UserModel>());
          expect(result, equals(tUserModel));
        },
      );
    },
  );

  group('toMap', () {
    test('should return a vaild [DataMap] from [UserModel]', () {
      // act
      final result = tUserModel.toMap();

      // assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [UserModel] with updated values',
      () {
        // act
        final result = tUserModel.copyWith(driverId: 2);

        //assert
        expect(result.driverId, 2);
      },
    );
  });
}
