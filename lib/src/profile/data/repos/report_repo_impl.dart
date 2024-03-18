import 'package:dartz/dartz.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/data/datasources/remote/report_remote_data_source.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/repos/report_repo.dart';

class ReportRepoImpl implements ReportRepo {
  ReportRepoImpl(this._remoteDataSource);

  final ReportRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<WeeklyReportItemEntity>> getWeeklyReport({
    required String orgId,
    required String driverId,
    required String from,
    required String to,
  }) async {
    try {
      final result = await _remoteDataSource.getWeeklyReport(
        orgId: orgId,
        driverId: driverId,
        from: from,
        to: to,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }
}
