import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/background_containder.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/orders/presentation/widgets/app_bars/orders_per_status_app_bar.dart';
import 'package:tayar_app/src/orders/presentation/widgets/list_views/order_list_tile.dart';

class OrdersPerStatusScreen extends StatelessWidget {
  const OrdersPerStatusScreen({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final statusOrderList = context.orderProvider.getOrdersPerStatus(status);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OrdersPerStatusAppBar(status: status.name.getString(context)),
      body: statusOrderList == null || statusOrderList.isEmpty
          ? BackgroundContainer(
              color: Colors.white,
              width: width,
              height: height,
              imgPath: loginImgPath,
              child: Center(
                child: Text(
                  AppLocale.noOrdersForStatus.getString(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              // itemExtent: 220.h,
              padding: EdgeInsets.all(10.w),
              itemBuilder: (context, index) {
                final order = statusOrderList[index];

                return OrderListTile(order: order);
              },
              itemCount: statusOrderList.length,
            ),
    );
  }
}
