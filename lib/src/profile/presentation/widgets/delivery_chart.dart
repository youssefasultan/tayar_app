import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/indicator.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/profile/data/models/weekly_report_item_model.dart';
import 'package:tayar_app/src/profile/presentation/bloc/report_bloc.dart';

class DeliveryChart extends StatefulWidget {
  const DeliveryChart({
    super.key,
  });

  @override
  State<DeliveryChart> createState() => _DeliveryChartState();
}

class _DeliveryChartState extends State<DeliveryChart> {
  Future<DateTimeRange?> dateRangePicker(BuildContext context) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        end: DateTime.now(),
        start: DateTime.now().subtract(const Duration(days: 7)),
      ),
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300.w, maxHeight: 500.h),
              child: child,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppLocale.report.getString(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(width: 15.w),
                ElevatedButton.icon(
                  onPressed: () async {
                    final time = await dateRangePicker(context);

                    if (time != null && context.mounted) {
                      context.read<ReportBloc>().add(
                            GetWeeklyReportEvent(
                              orgId: context.currentUser!.orgId.toString(),
                              driverId:
                                  context.currentUser!.driverId.toString(),
                              from: DateFormat('yyyy-MM-dd').format(time.start),
                              to: DateFormat('yyyy-MM-dd').format(time.end),
                            ),
                          );
                    }
                  },
                  icon: const Icon(
                    Ionicons.calendar,
                    color: kBlack,
                  ),
                  label: Text(
                    AppLocale.choosetDate.getString(context),
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                ),
                child: BlocConsumer<ReportBloc, ReportState>(
                  listener: (context, state) {
                    if (state is ReportLoaded) {
                      context.reportProvider.init(
                        state.reportList as List<WeeklyReportItemModel>,
                      );
                    }
                  },
                  builder: (context, state) {
                    final reportList = context.reportProvider.makeGroupData();
                    return state is ReportLoading
                        ? const Center(
                            child: SpinKitFadingCube(
                              color: kOrange,
                            ),
                          )
                        : state is ReportError
                            ? Center(
                                child: Text(
                                  AppLocale.reportError.getString(context),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: kBlack.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Indicator(
                                        color: kBlack,
                                        text: AppLocale.cancelled
                                            .getString(context),
                                        isSquare: false,
                                        textColor: kBlack,
                                      ),
                                      SizedBox(width: 10.w),
                                      Indicator(
                                        color: kBeige,
                                        text: AppLocale.delivered
                                            .getString(context),
                                        isSquare: false,
                                        textColor: kBeige,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: BarChart(
                                      BarChartData(
                                        maxY: 20,
                                        titlesData: FlTitlesData(
                                          rightTitles: const AxisTitles(),
                                          topTitles: const AxisTitles(),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) =>
                                                  bottomTitles(
                                                value,
                                                meta,
                                                context.reportProvider
                                                    .getBottomTitles(),
                                              ),
                                              reservedSize: 42,
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 28,
                                              interval: 1,
                                              getTitlesWidget: leftTitles,
                                            ),
                                          ),
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        barGroups: reportList,
                                        gridData: const FlGridData(show: false),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: kBeige,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 10) {
      text = '10';
    } else if (value == 19) {
      text = '20';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta, List<String> titles) {
    final Widget text = Text(
      titles[value.toInt()].replaceAll('.', '\n'),
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.normal,
        fontSize: 7.sp,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
