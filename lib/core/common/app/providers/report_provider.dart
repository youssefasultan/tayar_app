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

    _list!.removeWhere(
      (element) => element.delivered == 0 && element.cancelled == 0,
    );

    Future.delayed(Duration.zero, notifyListeners);
  }

  List<String> getBottomTitles() {
    return List<String>.generate(
      _list!.length,
      (index) => DateFormat('dd.MM')
          .format(DateFormat('yyyy-MM-dd').parse(_list![index].date)),
    );
  }

  List<BarChartGroupData> makeGroupData() {
    if (_list == null) return [];
    return List<BarChartGroupData>.generate(
      _list!.length,
      (index) => BarChartGroupData(
        barsSpace: 2.w,
        x: index,
        barRods: [
          BarChartRodData(
            toY: _list![index].delivered.toDouble(),
            color: kBeige,
            width: 5.w,
          ),
          BarChartRodData(
            toY: _list![index].cancelled.toDouble(),
            color: kBlack,
            width: 5.w,
          ),
        ],
      ),
    );
  }
}
