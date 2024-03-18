import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/data/models/weekly_report_item_model.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tWeeklyReportItemModel = WeeklyReportItemModel.empty();
  final tMap = jsonDecode(fixture('weekly_report_item.json')) as DataMap;

  test(
    'Should be subclass of [WeeklyReportItemEntity]',
    () => expect(tWeeklyReportItemModel, isA<WeeklyReportItemEntity>()),
  );

  group(
    'fromMap',
    () {
      test(
        'Should return a valid [UserModel] from the map',
        () {
          // act
          final result = WeeklyReportItemModel.fromMap(tMap);

          // assert
          expect(result, isA<WeeklyReportItemModel>());
          expect(result, equals(tWeeklyReportItemModel));
        },
      );
    },
  );

  group('toMap', () {
    test('should return a vaild [DataMap] from [UserModel]', () {
      // act
      final result = tWeeklyReportItemModel.toMap();

      // assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [UserModel] with updated values',
      () {
        // act
        final result = tWeeklyReportItemModel.copyWith(delivered: 2);

        //assert
        expect(result.delivered, 2);
      },
    );
  });
}
