import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/repos/report_repo.dart';
import 'package:tayar_app/src/profile/domian/usecases/get_weekly_report.dart';

class MockReportRepo extends Mock implements ReportRepo {}

void main() {
  late MockReportRepo repo;
  late GetWeeklyReport usecase;

  setUp(() {
    repo = MockReportRepo();
    usecase = GetWeeklyReport(repo);
  });
  final tWeeklyReportList = [const WeeklyReportItemEntity.empty()];
  const tGetWeeklyReportParams = GetWeeklyReportParams.empty();

  test('should return list of [WeeklyReportItemEntity] from [ReportRepo]',
      () async {
    when(
      () => repo.getWeeklyReport(
        orgId: any(named: 'orgId'),
        driverId: any(named: 'driverId'),
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer((_) async => Right(tWeeklyReportList));

    final result = await usecase(tGetWeeklyReportParams);

    expect(
      result,
      Right<dynamic, List<WeeklyReportItemEntity>>(tWeeklyReportList),
    );

    verify(
      () => repo.getWeeklyReport(
        orgId: tGetWeeklyReportParams.orgId,
        driverId: tGetWeeklyReportParams.driverId,
        from: tGetWeeklyReportParams.from,
        to: tGetWeeklyReportParams.to,
      ),
    ).called(1);

    verifyNoMoreInteractions(repo);
  });
}
