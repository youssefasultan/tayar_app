import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tayar_app/core/common/app/providers/orders_provider.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';
import 'package:tayar_app/src/orders/presentation/view/orders_per_status_screen.dart';

class OrderStatusGridView extends StatelessWidget {
  const OrderStatusGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainStatus = OrderStatus.getAllStatusesExceptInProcess();

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.h,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
      ),
      itemCount: mainStatus.length,
      itemBuilder: (_, index) {
        final status = mainStatus[index];
        final orderData = context.orderProvider;
        return statusGridTile(status, context, orderData);
      },
    );
  }

  Widget statusGridTile(
    OrderStatus status,
    BuildContext context,
    OrdersProvider orderData,
  ) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (_, state) {
        return InkWell(
          onTap: () {
            context.push(OrdersPerStatusScreen(status: status));
          },
          child: GridTile(
            key: ValueKey(status.id),
            footer: GridTileBar(
              backgroundColor: Colors.white54,
              title: Text(
                status.name.getString(context),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: state is GettingOrders
                    ? SizedBox(
                        width: 12.h,
                        height: 12.w,
                        child: SpinKitFadingCube(
                          color: kOrange,
                          size: 5.h,
                        ),
                      )
                    : Text(
                        '${orderData.getNoOfOrdersPerStatus(status)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: kBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: getStatusGadient(status),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
              child: Center(
                child: Image.asset(status.image),
                //  Icon(
                //   status.icon,
                //   size: 50.h,
                //   color: kBlack.withOpacity(0.8),
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
