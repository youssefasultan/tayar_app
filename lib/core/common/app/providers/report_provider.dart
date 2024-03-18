import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/profile/data/models/weekly_report_item_model.dart';

class ReportProvider extends ChangeNotifier {
  List<WeeklyReportItemModel>? _list;

  void init(List<WeeklyReportItemModel>? list) {
    if (_list != null) _list!.clear();
    _list = list;

    Future.delayed(Duration.zero, notifyListeners);
  }

  List<String> getBottomTitles() {
    return List<String>.generate(
      _list!.length,
      (index) => DateFormat('MM/dd')
          .format(DateFormat('yyyy-MM-dd').parse(_list![index].date)),
    );
  }

  List<BarChartGroupData> makeGroupData() {
    if (_list == null) return [];
    return List<BarChartGroupData>.generate(
      _list!.length,
      (index) => BarChartGroupData(
        barsSpace: 4,
        x: index,
        barRods: [
          BarChartRodData(
            toY: _list![index].delivered.toDouble(),
            color: kOrange,
            width: 7.w,
          ),
          BarChartRodData(
            toY: _list![index].cancelled.toDouble(),
            color: kBeige,
            width: 7.w,
          ),
        ],
      ),
    );
  }
}
