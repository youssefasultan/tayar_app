part of 'report_bloc.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

final class ReportInitial extends ReportState {
  const ReportInitial();
}

class ReportError extends ReportState {
  const ReportError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

class ReportLoading extends ReportState {
  const ReportLoading();
}

class ReportLoaded extends ReportState {
  const ReportLoaded(this.reportList);

  final List<WeeklyReportItemEntity> reportList;

  @override
  List<Object> get props => reportList.map((e) => e.date).toList();
}
