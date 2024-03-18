import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/src/profile/data/datasources/remote/report_remote_data_source.dart';
import 'package:tayar_app/src/profile/data/models/weekly_report_item_model.dart';
import 'package:tayar_app/src/profile/domian/usecases/get_weekly_report.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late ReportRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = ReportRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  const tException = ServerException(message: 'Not found', statusCode: 500);

  group('get weekly report', () {
    final tWeeklyReportItemModelList = [const WeeklyReportItemModel.empty()];
    const tGetWeeklyReportParams = GetWeeklyReportParams.empty();
    test('Should return a list of [WeeklyReportItemModel] when status is 200',
        () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode({
            'data': [tWeeklyReportItemModelList.first.toMap()],
          }),
          200,
        ),
      );

      final result = await remoteDataSource.getWeeklyReport(
        orgId: tGetWeeklyReportParams.orgId,
        driverId: tGetWeeklyReportParams.driverId,
        from: tGetWeeklyReportParams.from,
        to: tGetWeeklyReportParams.to,
      );

      expect(result, equals(tWeeklyReportItemModelList));

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kGetWeeklyReportEndPoint,
          ),
          headers: kHeader,
          body: jsonEncode({
            'orgId': tGetWeeklyReportParams.orgId,
            'driverId': tGetWeeklyReportParams.driverId,
            'from': tGetWeeklyReportParams.from,
            'to': tGetWeeklyReportParams.to,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw [ServerException] when status code is not 200 or 201',
        () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenThrow(tException);

      final methodCall = remoteDataSource.getWeeklyReport;

      expect(
        () async => methodCall(
          orgId: tGetWeeklyReportParams.orgId,
          driverId: tGetWeeklyReportParams.driverId,
          from: tGetWeeklyReportParams.from,
          to: tGetWeeklyReportParams.to,
        ),
        throwsA(
          ServerException(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kGetWeeklyReportEndPoint,
          ),
          headers: kHeader,
          body: jsonEncode({
            'orgId': tGetWeeklyReportParams.orgId,
            'driverId': tGetWeeklyReportParams.driverId,
            'from': tGetWeeklyReportParams.from,
            'to': tGetWeeklyReportParams.to,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
