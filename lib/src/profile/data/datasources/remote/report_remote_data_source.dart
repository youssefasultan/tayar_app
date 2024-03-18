import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/data/models/weekly_report_item_model.dart';

abstract class ReportRemoteDataSource {
  const ReportRemoteDataSource();

  Future<List<WeeklyReportItemModel>> getWeeklyReport({
    required String orgId,
    required String driverId,
    required String from,
    required String to,
  });
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  ReportRemoteDataSourceImpl(this._client);

  final http.Client _client;
  @override
  Future<List<WeeklyReportItemModel>> getWeeklyReport({
    required String orgId,
    required String driverId,
    required String from,
    required String to,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(
          kBaseUrl,
          kGetWeeklyReportEndPoint,
        ),
        headers: kHeader,
        body: jsonEncode({
          'orgId': orgId,
          'driverId': driverId,
          'from': from,
          'to': to,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final responseData = jsonDecode(response.body) as DataMap;

      return List<DataMap>.from(responseData['data'] as List)
          .map(WeeklyReportItemModel.fromMap)
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
