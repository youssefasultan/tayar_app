import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/usecases/get_weekly_report.dart';
import 'package:tayar_app/src/profile/presentation/bloc/report_bloc.dart';

class MockGetWeeklyReport extends Mock implements GetWeeklyReport {}

void main() {
  late GetWeeklyReport getWeeklyReport;
  late ReportBloc reportBloc;

  setUp(() {
    getWeeklyReport = MockGetWeeklyReport();
    reportBloc = ReportBloc(getWeeklyReport: getWeeklyReport);
  });

  const tGetWeeklyReportParams = GetWeeklyReportParams.empty();
  const tServerFailure = ServerFailure(
    message: 'orders-not-found',
    statusCode: 'there is no user recored',
  );

  setUpAll(() {
    registerFallbackValue(tGetWeeklyReportParams);
    registerFallbackValue(tServerFailure);
  });

  tearDown(() => reportBloc.close());

  test('initialState should be [ReportInitial]', () {
    expect(reportBloc.state, const ReportInitial());
  });

  group('Get weekly report', () {
    const tWeeklyReportList = [WeeklyReportItemEntity.empty()];

    blocTest<ReportBloc, ReportState>(
      'should emit [ReportLoading, ReportLoaded] '
      'when [GetWeeklyReportEvent] is added',
      build: () {
        when(
          () => getWeeklyReport(any()),
        ).thenAnswer((_) async => const Right(tWeeklyReportList));

        return reportBloc;
      },
      act: (bloc) => bloc.add(
        GetWeeklyReportEvent(
          orgId: tGetWeeklyReportParams.orgId,
          driverId: tGetWeeklyReportParams.driverId,
          from: tGetWeeklyReportParams.from,
          to: tGetWeeklyReportParams.to,
        ),
      ),
      expect: () => [
        const ReportLoading(),
        const ReportLoaded(tWeeklyReportList),
      ],
      verify: (_) {
        verify(
          () => getWeeklyReport(tGetWeeklyReportParams),
        ).called(1);
        verifyNoMoreInteractions(getWeeklyReport);
      },
    );

    blocTest<ReportBloc, ReportState>(
      'should emit [ReportLoading, ReportError] '
      'when [GetWeeklyReport] fails',
      build: () {
        when(
          () => getWeeklyReport(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));

        return reportBloc;
      },
      act: (bloc) => bloc.add(
        GetWeeklyReportEvent(
          orgId: tGetWeeklyReportParams.orgId,
          driverId: tGetWeeklyReportParams.driverId,
          from: tGetWeeklyReportParams.from,
          to: tGetWeeklyReportParams.to,
        ),
      ),
      expect: () => [
        const ReportLoading(),
        ReportError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => getWeeklyReport(tGetWeeklyReportParams),
        ).called(1);
        verifyNoMoreInteractions(getWeeklyReport);
      },
    );
  });
}
