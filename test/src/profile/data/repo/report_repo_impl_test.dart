import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/profile/data/datasources/remote/report_remote_data_source.dart';
import 'package:tayar_app/src/profile/data/repos/report_repo_impl.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/usecases/get_weekly_report.dart';

class MockReportRemoteDataSource extends Mock
    implements ReportRemoteDataSource {}

void main() {
  late ReportRepoImpl repoImpl;
  late ReportRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockReportRemoteDataSource();
    repoImpl = ReportRepoImpl(remoteDataSource);
  });

  const tException = ServerException(message: 'Not found', statusCode: 500);

  group('Get Weekly Report', () {
    const tGetWeeklyReportParams = GetWeeklyReportParams.empty();

    test(
        'Should call [ReportRemoteDataSource.getWeeklyReport] and '
        'Return list of [WeeklyReportItemModel] when successfully', () async {
      when(
        () => remoteDataSource.getWeeklyReport(
          orgId: any(named: 'orgId'),
          driverId: any(named: 'driverId'),
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenAnswer((_) async => []);

      final result = await repoImpl.getWeeklyReport(
        orgId: tGetWeeklyReportParams.orgId,
        driverId: tGetWeeklyReportParams.driverId,
        from: tGetWeeklyReportParams.from,
        to: tGetWeeklyReportParams.to,
      );

      expect(result, isA<Right<dynamic, List<WeeklyReportItemEntity>>>());
      verify(
        () => remoteDataSource.getWeeklyReport(
          orgId: tGetWeeklyReportParams.orgId,
          driverId: tGetWeeklyReportParams.driverId,
          from: tGetWeeklyReportParams.from,
          to: tGetWeeklyReportParams.to,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      'Should return [ServerFailure] when call to '
      '[OrderRemoteDataSource.getOrders] is unsuccessfull',
      () async {
        when(
          () => remoteDataSource.getWeeklyReport(
            orgId: any(named: 'orgId'),
            driverId: any(named: 'driverId'),
            from: any(named: 'from'),
            to: any(named: 'to'),
          ),
        ).thenThrow(tException);

        final result = await repoImpl.getWeeklyReport(
          orgId: tGetWeeklyReportParams.orgId,
          driverId: tGetWeeklyReportParams.driverId,
          from: tGetWeeklyReportParams.from,
          to: tGetWeeklyReportParams.to,
        );

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.getWeeklyReport(
            orgId: tGetWeeklyReportParams.orgId,
            driverId: tGetWeeklyReportParams.driverId,
            from: tGetWeeklyReportParams.from,
            to: tGetWeeklyReportParams.to,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
