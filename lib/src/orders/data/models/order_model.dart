import 'dart:convert';

import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/models/order_item_model.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.orderId,
    required super.customerName,
    required super.customerAddress,
    required super.customerPhoneNo,
    required super.totalAmount,
    required super.status,
    required super.paymentType,
    required super.note,
    required super.items,
  });

  OrderModel.fromMap(DataMap map)
      : this(
          orderId: map['orderNo'] as String,
          customerName: map['customerName'] as String,
          customerAddress: map['customerAddress'] as String,
          customerPhoneNo: map['customerPhoneNo'] as String,
          totalAmount: map['totalAmount'] as double,
          status: OrderStatus.values.firstWhere(
            (element) => element.code == (map['status'] as String),
          ),
          paymentType: PaymentType.values.firstWhere(
            (element) => element.name == (map['paymentType'] as String),
          ),
          note: map['note'] as String,
          items: (map['items'] as List<dynamic>)
              .map((e) => OrderItemModel.fromMap(e as DataMap))
              .toList(),
        );

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(jsonDecode(source) as DataMap);

  OrderModel.empty()
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

  OrderModel copyWith({
    String? orderId,
    String? customerName,
    String? customerAddress,
    String? customerPhoneNo,
    double? totalAmount,
    OrderStatus? status,
    PaymentType? paymentType,
    String? note,
    List<OrderItemModel>? items,
  }) =>
      OrderModel(
        orderId: orderId ?? this.orderId,
        customerName: customerName ?? this.customerName,
        customerAddress: customerAddress ?? this.customerAddress,
        customerPhoneNo: customerPhoneNo ?? this.customerPhoneNo,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        paymentType: paymentType ?? this.paymentType,
        note: note ?? this.note,
        items: items ?? this.items,
      );

  DataMap toMap() => {
        'orderNo': orderId,
        'customerName': customerName,
        'customerAddress': customerAddress,
        'customerPhoneNo': customerPhoneNo,
        'totalAmount': totalAmount,
        'status': status.code,
        'paymentType': paymentType.name,
        'note': note,
        'items': items.map((e) => (e as OrderItemModel).toMap()).toList(),
      };

  String toJson() => jsonEncode(toMap());
}
