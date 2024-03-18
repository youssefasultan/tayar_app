import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/models/order_item_model.dart';
import 'package:tayar_app/src/orders/domain/entities/order_item_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tOrderItemModel = OrderItemModel.empty();
  final tMap = jsonDecode(fixture('order_item.json')) as DataMap;
  test(
    'Should be subclass of [OrderItemEntity]',
    () => expect(tOrderItemModel, isA<OrderItemEntity>()),
  );

  group(
    'fromMap',
    () {
      test(
        'Should return a valid [UserModel] from the map',
        () {
          // act
          final result = OrderItemModel.fromMap(tMap);

          // assert
          expect(result, isA<OrderItemModel>());
          expect(result, equals(tOrderItemModel));
        },
      );
    },
  );

  group('toMap', () {
    test('should return a vaild [DataMap] from [UserModel]', () {
      // act
      final result = tOrderItemModel.toMap();

      // assert
      expect(result, equals(tMap));
    });


    group('copyWith', () {
    test(
      'should return a valid [UserModel] with updated values',
      () {
        // act
        final result = tOrderItemModel.copyWith(itemId: 2);

        //assert
        expect(result.itemId, 2);
      },
    );
  });
  });
}
