import 'dart:convert';

import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';

class WeeklyReportItemModel extends WeeklyReportItemEntity {
  const WeeklyReportItemModel({
    required super.date,
    required super.delivered,
    required super.cancelled,
  });

  WeeklyReportItemModel.fromMap(DataMap map)
      : this(
          cancelled: map['numberOfCanceledOrders'] as int,
          date: map['date'] as String,
          delivered: map['numberOfDeliveredOrders'] as int,
        );

  factory WeeklyReportItemModel.fromJson(String source) =>
      WeeklyReportItemModel.fromMap(jsonDecode(source) as DataMap);

  const WeeklyReportItemModel.empty()
      : this(
          cancelled: 0,
          date: '',
          delivered: 0,
        );

  WeeklyReportItemModel copyWith({
    int? delivered,
    int? cancelled,
    String? date,
  }) =>
      WeeklyReportItemModel(
        date: date ?? this.date,
        delivered: delivered ?? this.delivered,
        cancelled: cancelled ?? this.cancelled,
      );

  DataMap toMap() => {
        'date': date,
        'numberOfDeliveredOrders': delivered,
        'numberOfCanceledOrders': cancelled,
      };

  String toJson() => jsonEncode(toMap());
}
