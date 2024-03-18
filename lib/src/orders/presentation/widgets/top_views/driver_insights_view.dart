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
import 'package:tayar_app/core/common/widgets/outlined_text.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/services/call_service.dart';
import 'package:tayar_app/core/services/injection_container.dart';
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
    final inprocessOrder = orderData.inProcessOrder;
    // for test purposes
    // final inprocessOrder = OrderModel.empty().copyWith(
    //   orderId: '121212',
    //   customerName: 'youssef',
    //   customerAddress: '157 west gold, 5th setelment, new cairo, cairo',
    //   customerPhoneNo: '010010101',
    // );

    final carouselItems = [
      cashInsight(context, orderData),
    ];

    if (inprocessOrder != null) {
      carouselItems.insert(0, inprocessInsight(context, inprocessOrder));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: BackgroundContainer(
        width: width,
        height: height * 0.3,
        color: Colors.white,
        imgPath: bannerImgPath,
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
                      color: kBlue.withOpacity(
                        _current == carouselItems.indexOf(entry) ? 0.9 : 0.4,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget inprocessInsight(BuildContext context, OrderModel order) {
    return InkWell(
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
            OutLinedText(
              label: AppLocale.inProcess.getString(context),
              labelSize: 30,
              fontWeight: FontWeight.bold,
              strokeWidth: 3,
              strokeColor: Colors.white,
              textColor: kOrange,
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
                        color: kBlue,
                        size: 30.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        order.orderId,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: kBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                          color: kBlue,
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
                        color: kBlue,
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
                            color: kBlue,
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
                            color: kBlue,
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
    );
  }

  Widget cashInsight(BuildContext context, OrdersProvider orderData) {
    return Padding(
      padding: EdgeInsets.all(10.w),
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
                  color: kBlue,
                ),
              ),
              Text(
                '${orderData.getdeliveredCashOrders()} / ${orderData.getNoOfCashOrders()}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: kBlue,
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
            color: kBlue,
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
                  color: kBlue,
                ),
              ),
              Text(
                '${orderData.getCollectedCash()} / ${orderData.getExpectedCash().toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: kBlue,
                ),
              ),
            ],
          ),
          ProgressBar(
            width: width,
            value: orderData.getCollectedCash() == 0.0
                ? 0
                : orderData.getCollectedCash() / orderData.getExpectedCash(),
            color: kBlue,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
