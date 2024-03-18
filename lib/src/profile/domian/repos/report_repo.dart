import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';

abstract class ReportRepo {
  const ReportRepo();

  ResultFuture<List<WeeklyReportItemEntity>> getWeeklyReport({
    required String orgId,
    required String driverId,
    required String from,
    required String to,
  });
}
