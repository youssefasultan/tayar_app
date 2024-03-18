import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/repos/report_repo.dart';

class GetWeeklyReport extends UsecaseWithParams<List<WeeklyReportItemEntity>,
    GetWeeklyReportParams> {
  GetWeeklyReport(this._repo);

  final ReportRepo _repo;

  @override
  ResultFuture<List<WeeklyReportItemEntity>> call(
    GetWeeklyReportParams params,
  ) =>
      _repo.getWeeklyReport(
        orgId: params.orgId,
        driverId: params.driverId,
        from: params.from,
        to: params.to,
      );
}

class GetWeeklyReportParams extends Equatable {
  const GetWeeklyReportParams({
    required this.driverId,
    required this.orgId,
    required this.from,
    required this.to,
  });

  const GetWeeklyReportParams.empty()
      : this(driverId: '', orgId: '', from: '', to: '');

  final String driverId;
  final String orgId;
  final String from;
  final String to;

  @override
  List<Object?> get props => [driverId];
}
