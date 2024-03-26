import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/services/call_service.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';
import 'package:tayar_app/src/orders/presentation/view/order_details_screen.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    required this.order,
    super.key,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 15.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: kLinerGradient(order.status),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Ionicons.cart,
                            color: Colors.white,
                            size: 30.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            order.orderId,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: order.paymentType == PaymentType.CASH
                            ? Padding(
                                padding: EdgeInsets.all(5.w),
                                child: Icon(
                                  Ionicons.cash,
                                  color: Colors.white,
                                  size: 25.w,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(5.w),
                                child: Icon(
                                  Ionicons.card,
                                  color: Colors.white,
                                  size: 25.w,
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        Ionicons.person_circle,
                        color: Colors.white,
                        size: 30.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        order.customerName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        Ionicons.home,
                        color: Colors.white,
                        size: 30.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Flexible(
                        child: Text(
                          order.customerAddress,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        Ionicons.call,
                        color: Colors.white,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w),
            IconButton(
              onPressed: () {
                context.push(
                  BlocProvider(
                    create: (_) => sl<OrderBloc>(),
                    child: OrderDetailsScreen(
                      order: order,
                    ),
                  ),
                );
              },
              icon: Icon(
                Ionicons.arrow_back_circle_outline,
                color: Colors.white,
                size: 40.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
