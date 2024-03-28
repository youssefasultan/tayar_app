import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';
import 'package:tayar_app/src/orders/presentation/widgets/app_bars/order_details_app_bar.dart';
import 'package:tayar_app/src/orders/presentation/widgets/top_views/order_detail_header.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({required this.order, super.key});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final localization = FlutterLocalization.instance;

    return BlocListener<OrderBloc, OrderState>(
      listener: (_, state) {
        if (state is UpdatingOrderStatus) {
          CoreUtils.showLoadingDialog(context);
        } else if (state is OrderError) {
          CoreUtils.closeDialog(context);
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is OrderStatusUpdated) {
          CoreUtils.closeDialog(context);
          CoreUtils.showSuccessSnackBar(
            context,
            AppLocale.successfully.getString(context),
          );
          context.popToHome();
        }
      },
      child: Scaffold(
        appBar: OrderDetailAppBar(order: order),
        body: Column(
          children: [
            OrderDetailsHeader(order: order),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: kBlack.withOpacity(0.7),
                    ),
                    child: ListTile(
                      leading: Text(
                        '${item.quantity} X',
                        style: TextStyle(
                          color: kOrange,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        localization.currentLocale!.languageCode == 'en'
                            ? item.itemNameEn
                            : item.itemNameAr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        item.uomEn,
                        style: TextStyle(
                          color: kOrange,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
