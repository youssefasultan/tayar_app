import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tOrderModel = OrderModel.empty();
  final tMap = jsonDecode(fixture('order.json')) as DataMap;
  test(
    'Should be subclass of [OrderItemEntity]',
    () => expect(tOrderModel, isA<OrderEntity>()),
  );

  group(
    'fromMap',
    () {
      test(
        'Should return a valid [UserModel] from the map',
        () {
          // act
          final result = OrderModel.fromMap(tMap);

          // assert
          expect(result, isA<OrderModel>());
          expect(result, equals(tOrderModel));
        },
      );
    },
  );

  group('toMap', () {
    test('should return a vaild [DataMap] from [UserModel]', () {
      // act
      final result = tOrderModel.toMap();

      // assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [UserModel] with updated values',
      () {
        // act
        final result = tOrderModel.copyWith(totalAmount: 2);

        //assert
        expect(result.totalAmount, 2);
      },
    );
  });
}
