import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/background_containder.dart';
import 'package:tayar_app/core/services/call_service.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({
    required this.order,
    super.key,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: BackgroundContainer(
        width: width,
        height: height * 0.3,
        color: Colors.white,
        imgPath: bannerImgPath,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Ionicons.person_circle,
                    color: kBlue,
                    size: 30.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    order.customerName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Ionicons.home,
                    color: kBlue,
                    size: 30.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Text(
                      order.customerAddress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: kBlue,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Ionicons.call,
                    color: kBlue,
                    size: 30.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  InkWell(
                    onTap: () => CallService(context)
                        .makePhoneCall(order.customerPhoneNo),
                    child: Text(
                      order.customerPhoneNo,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: kBlue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${AppLocale.paymentType.getString(context)} '
                    ': ${order.paymentType.locale.getString(context)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlue,
                    ),
                  ),
                  Text(
                    '${AppLocale.onOfItems.getString(context)} '
                    ': ${order.items.length}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2.h,
                color: kLightBlue,
                indent: 10.w,
                endIndent: 10.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Ionicons.cash,
                        color: kBlue,
                        size: 30.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        '${order.totalAmount} '
                        '${AppLocale.egp.getString(context)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: kBlue,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${AppLocale.orderStatus.getString(context)} '
                    ': ${order.status.name.getString(context)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: order.status.statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
