import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/app/providers/orders_provider.dart';
import 'package:tayar_app/core/common/widgets/background_containder.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/services/call_service.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';
import 'package:tayar_app/src/orders/presentation/view/order_details_screen.dart';

class DriverInsightsView extends StatefulWidget {
  const DriverInsightsView({super.key});

  @override
  State<DriverInsightsView> createState() => _DriverInsightsViewState();
}

class _DriverInsightsViewState extends State<DriverInsightsView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final orderData = context.orderProvider;
    final inprocessOrders = orderData.inProcessOrder;

    final carouselItems = [
      cashInsight(context, orderData),
    ];

    if (inprocessOrders != null) {
      for (final order in inprocessOrders) {
        carouselItems.add(inprocessInsight(context, order));
      }
    }

    return SizedBox(
      height: height * 0.3,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: carouselItems,
              carouselController: _controller,
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                height: height,
                enlargeFactor: 0.2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          if (carouselItems.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselItems.map((entry) {
                return Container(
                  width: 6.w,
                  height: 10.h,
                  margin: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 4.w,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBlack.withOpacity(
                      _current == carouselItems.indexOf(entry) ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget inprocessInsight(BuildContext context, OrderModel order) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: BackgroundContainer(
        width: width,
        height: height,
        color: kBlack,
        radiusGeometry: BorderRadius.all(Radius.circular(20.r)),
        imgPath: bannerImgPath,
        child: InkWell(
          onTap: () => context.push(
            BlocProvider(
              create: (_) => sl<OrderBloc>(),
              child: OrderDetailsScreen(
                order: order,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(5.w),
            child: Column(
              children: [
                Text(
                  AppLocale.inProcess.getString(context),
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                                overflow: TextOverflow.clip,
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cashInsight(BuildContext context, OrdersProvider orderData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: BackgroundContainer(
        width: width,
        height: height,
        color: kBlack,
        radiusGeometry: BorderRadius.all(Radius.circular(20.r)),
        imgPath: bannerImgPath,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocale.cashOrders.getString(context)}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${orderData.getdeliveredCashOrders()} / ${orderData.getNoOfCashOrders()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ProgressBar(
                width: width,
                value: orderData.getdeliveredCashOrders() == 0
                    ? 0
                    : orderData.getdeliveredCashOrders() /
                        orderData.getNoOfCashOrders(),
                gradient: kLinerGradient(OrderStatus.DELIVERED),
                backgroundColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocale.collected.getString(context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${orderData.getCollectedCash()} / ${orderData.getExpectedCash().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ProgressBar(
                width: width,
                value: orderData.getCollectedCash() == 0.0
                    ? 0
                    : orderData.getCollectedCash() /
                        orderData.getExpectedCash(),
                gradient: kLinerGradient(OrderStatus.DELIVERED),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
