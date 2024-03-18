import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/usecases/get_orders.dart';
import 'package:tayar_app/src/orders/domain/usecases/update_order_status.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required GetOrders getOrders,
    required UpdateOrderStatus updateOrderStatus,
  })  : _getOrders = getOrders,
        _updateOrderStatus = updateOrderStatus,
        super(const OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<GetOrdersEvent>(_getOrdersHandler);
    on<UpdateOrderEvent>(_updateOrderStatusHandler);
  }

  final GetOrders _getOrders;
  final UpdateOrderStatus _updateOrderStatus;

  Future<void> _getOrdersHandler(
    GetOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const GettingOrders());
    final result = await _getOrders(
      GetOrdersParams(
        driverId: event.driverId,
        orgId: event.orgId,
      ),
    );

    result.fold(
      (failure) => emit(OrderError(message: failure.errorMessage)),
      (orderList) => emit(OrdersLoaded(orderList)),
    );
  }

  Future<void> _updateOrderStatusHandler(
    UpdateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const UpdatingOrderStatus());
    final result = await _updateOrderStatus(
      UpdateOrderParams(
        orgId: event.orgId,
        orderId: event.orderId,
        status: event.status,
        cancelReason: event.cancelReason,
        driverId: event.driverId,
        note: event.note,
      ),
    );

    result.fold(
      (failure) => emit(OrderError(message: failure.errorMessage)),
      (r) => emit(const OrderStatusUpdated()),
    );
  }
}
