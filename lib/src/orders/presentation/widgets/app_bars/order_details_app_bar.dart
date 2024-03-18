import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/nested_back_button.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';

class OrderDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderDetailAppBar({
    required this.order,
    super.key,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const NestedbackButton(),
      title: Text(
        '${AppLocale.orderNo.getString(context)} ${order.orderId}',
        style: TextStyle(
          fontSize: 20.sp,
          color: kBlue,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      actions: getActions(context),
      forceMaterialTransparency: true,
    );
  }

  List<Widget>? getActions(BuildContext context) {
    final orderBloc = context.read<OrderBloc>();
    switch (order.status) {
      case OrderStatus.NEW:
        return [
          TextButton(
            onPressed: () {
              orderBloc.add(
                UpdateOrderEvent(
                  kOrgId,
                  order.orderId,
                  OrderStatus.INPROCESS.code,
                  0,
                  context.currentUser!.driverId.toString(),
                  '',
                ),
              );
            },
            child: Text(
              AppLocale.inProcess.getString(context),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: OrderStatus.INPROCESS.statusColor,
              ),
            ),
          ),
        ];

      case OrderStatus.INPROCESS:
        return [
          PopupMenuButton<OrderStatus>(
            onSelected: (value) => handleClick(value, context),
            itemBuilder: (_) => [
              PopupMenuItem<OrderStatus>(
                value: OrderStatus.DELIVERED,
                child: Text(
                  OrderStatus.DELIVERED.name.getString(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: OrderStatus.DELIVERED.statusColor,
                  ),
                ),
              ),
              PopupMenuItem<OrderStatus>(
                value: OrderStatus.CANCELLED,
                child: Text(
                  OrderStatus.CANCELLED.name.getString(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: OrderStatus.CANCELLED.statusColor,
                  ),
                ),
              ),
            ],
          ),
        ];
      case OrderStatus.DELIVERED:
      case OrderStatus.CANCELLED:
        return [];
    }
  }

  Future<void> handleClick(OrderStatus status, BuildContext context) async {
    final orderBloc = context.read<OrderBloc>();
    switch (status) {
      case OrderStatus.DELIVERED:
        orderBloc.add(
          UpdateOrderEvent(
            kOrgId,
            order.orderId,
            OrderStatus.DELIVERED.code,
            0,
            context.currentUser!.driverId.toString(),
            '',
          ),
        );
      case OrderStatus.CANCELLED:
        final result =
            await CoreUtils.showCancelReasonDialog(context, order.orderId);
        orderBloc.add(
          UpdateOrderEvent(
            kOrgId,
            order.orderId,
            OrderStatus.DELIVERED.code,
            result!['reasonId'] as int,
            context.mounted ? context.currentUser!.driverId.toString() : '',
            result['text'] as String,
          ),
        );

      case OrderStatus.NEW:
      case OrderStatus.INPROCESS:
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
