part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class GetWeeklyReportEvent extends ReportEvent {
  const GetWeeklyReportEvent({
    required this.orgId,
    required this.driverId,
    required this.from,
    required this.to,
  });

  final String orgId;
  final String driverId;
  final String from;
  final String to;

  @override
  List<Object> get props => [driverId];
}
