import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/src/orders/domain/entities/order_item_entity.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.orderId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhoneNo,
    required this.totalAmount,
    required this.status,
    required this.paymentType,
    required this.note,
    required this.items,
  });

  OrderEntity.empty()
      : this(
          orderId: '',
          customerName: '',
          customerAddress: '',
          customerPhoneNo: '',
          totalAmount: 0,
          status: OrderStatus.NEW,
          paymentType: PaymentType.CASH,
          note: '',
          items: [],
        );

  final String orderId;
  final String customerName;
  final String customerAddress;
  final String customerPhoneNo;
  final double totalAmount;
  final OrderStatus status;
  final PaymentType paymentType;
  final String note;
  final List<OrderItemEntity> items;

  @override
  List<Object?> get props => [orderId, customerName, customerAddress, status];

  @override
  String toString() => 'Order(orderId: $orderId, customerName: $customerName, '
      'customerAddres: $customerAddress), customerPhoneNo: $customerPhoneNo '
      'totalAmount: $totalAmount, status: $status, paymentType: $paymentType '
      'note: $note, items: ${items.map((e) => e.toString()).toList()}';
}
