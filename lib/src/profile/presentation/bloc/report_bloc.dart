import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tayar_app/src/profile/domian/entites/weekly_report_item_entity.dart';
import 'package:tayar_app/src/profile/domian/usecases/get_weekly_report.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc({
    required GetWeeklyReport getWeeklyReport,
  })  : _getWeeklyReport = getWeeklyReport,
        super(const ReportInitial()) {
    on<ReportEvent>((event, emit) {
      emit(const ReportLoading());
    });

    on<GetWeeklyReportEvent>(_getWeeklyReportHandler);
  }

  final GetWeeklyReport _getWeeklyReport;

  FutureOr<void> _getWeeklyReportHandler(
    GetWeeklyReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    final result = await _getWeeklyReport(
      GetWeeklyReportParams(
        driverId: event.driverId,
        orgId: event.orgId,
        from: event.from,
        to: event.to,
      ),
    );

    result.fold(
      (failure) => emit(ReportError(message: failure.errorMessage)),
      (weeklyReportList) => emit(ReportLoaded(weeklyReportList)),
    );
  }
}
