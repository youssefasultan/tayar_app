import 'package:equatable/equatable.dart';

class WeeklyReportItemEntity extends Equatable {
  const WeeklyReportItemEntity({
    required this.date,
    required this.delivered,
    required this.cancelled,
  });

  const WeeklyReportItemEntity.empty()
      : this(
          cancelled: 0,
          date: '',
          delivered: 0,
        );

  final String date;
  final int delivered;
  final int cancelled;

  @override
  List<Object?> get props => [date, cancelled, delivered];

  @override
  String toString() => 'WeeklyReportItem(date: $date, delivered: $delivered, '
      'cancelled: $cancelled)';
}
