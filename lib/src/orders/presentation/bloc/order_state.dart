part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderError extends OrderState {
  const OrderError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

class GettingOrders extends OrderState {
  const GettingOrders();
}

class OrdersLoaded extends OrderState {
  const OrdersLoaded(this.orders);

  final List<OrderEntity> orders;

  @override
  List<Object> get props => orders.map((e) => e.orderId).toList();
}

class UpdatingOrderStatus extends OrderState {
  const UpdatingOrderStatus();
}

class OrderStatusUpdated extends OrderState {
  const OrderStatusUpdated();
}
