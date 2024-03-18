import 'dart:convert';

import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.itemId,
    required super.itemName,
    required super.quantity,
    required super.uom,
  });

  OrderItemModel.fromMap(DataMap map)
      : this(
          itemId: map['productID'] as int,
          itemName: map['productName'] as String,
          quantity: map['quantity'] as int,
          uom: map['uom'] as String,
        );

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(jsonDecode(source) as DataMap);

  const OrderItemModel.empty()
      : this(
          itemId: 0,
          itemName: '',
          quantity: 0,
          uom: '',
        );

  OrderItemModel copyWith({
    int? itemId,
    String? itemName,
    int? quantity,
    String? uom,
  }) =>
      OrderItemModel(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        quantity: quantity ?? this.quantity,
        uom: uom ?? this.uom,
      );

  DataMap toMap() => {
        'productID': itemId,
        'productName': itemName,
        'quantity': quantity,
        'uom': uom,
      };

  String toJson() => jsonEncode(toMap());
}
