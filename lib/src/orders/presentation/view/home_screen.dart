import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';

import 'package:tayar_app/src/orders/presentation/widgets/app_bars/home_app_bar.dart';
import 'package:tayar_app/src/orders/presentation/widgets/list_views/order_status_grid_view.dart';
import 'package:tayar_app/src/orders/presentation/widgets/top_views/driver_insights_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void didChangeDependencies() {
    context.read<OrderBloc>().add(
          GetOrdersEvent(
            kOrgId,
            context.currentUser!.driverId.toString(),
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: Colors.white,
      body: BlocConsumer<OrderBloc, OrderState>(
        builder: (context, state) => LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          showChildOpacityTransition: false,
          borderWidth: 10.h,
          color: kOrange,
          backgroundColor: kBlack,
          onRefresh: () async {
            context.read<OrderBloc>().add(
                  GetOrdersEvent(
                    kOrgId,
                    context.currentUser!.driverId.toString(),
                  ),
                );
          },
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              if (state is GettingOrders)
                SizedBox(
                  height: height * 0.3,
                  child: const Center(
                    child: SpinKitFadingCube(
                      color: kOrange,
                    ),
                  ),
                )
              else
                const DriverInsightsView(),
              const OrderStatusGridView(),
            ],
          ),
        ),
        listener: (context, state) {
          if (state is OrderError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is OrdersLoaded) {
            context.orderProvider.init(state.orders.cast<OrderModel>());
          }
        },
      ),
    );
  }
}
