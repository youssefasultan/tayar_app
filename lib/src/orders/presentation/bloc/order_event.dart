part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersEvent extends OrderEvent {
  const GetOrdersEvent(
    this.orgId,
    this.driverId,
  );

  final String orgId;
  final String driverId;

  @override
  List<Object> get props => [driverId];
}

class UpdateOrderEvent extends OrderEvent {
  const UpdateOrderEvent(
    this.orgId,
    this.orderId,
    this.status,
    this.cancelReason,
    this.driverId,
    this.note,
  );

  final String orgId;
  final String orderId;
  final String status;
  final int cancelReason;
  final String driverId;
  final String note;

  @override
  List<Object> get props => [orderId, status];
}
