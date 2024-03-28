import 'dart:convert';

import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.itemId,
    required super.itemNameEn,
    required super.quantity,
    required super.uomEn,
    required super.itemNameAr,
    required super.uomAr,
  });

  OrderItemModel.fromMap(DataMap map)
      : this(
          itemId: map['productID'] as int,
          itemNameEn: map['productNameEN'] as String,
          quantity: map['quantity'] as int,
          uomEn: map['uomEN'] as String,
          itemNameAr: map['productNameAR'] as String,
          uomAr: map['uomAR'] as String,
        );

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(jsonDecode(source) as DataMap);

  const OrderItemModel.empty()
      : this(
          itemId: 0,
          itemNameEn: '',
          itemNameAr: '',
          quantity: 0,
          uomEn: '',
          uomAr: '',
        );

  OrderItemModel copyWith({
    int? itemId,
    String? itemNameEn,
    String? itemNameAr,
    int? quantity,
    String? uomEn,
    String? uomAr,
  }) =>
      OrderItemModel(
        itemId: itemId ?? this.itemId,
        itemNameEn: itemNameEn ?? this.itemNameEn,
        itemNameAr: itemNameAr ?? this.itemNameAr,
        quantity: quantity ?? this.quantity,
        uomEn: uomEn ?? this.uomEn,
        uomAr: uomAr ?? this.uomAr,
      );

  DataMap toMap() => {
        'productID': itemId,
        'productNameEN': itemNameEn,
        'productNameAR': itemNameAr,
        'quantity': quantity,
        'uomEN': uomEn,
        'uomAR': uomAr,
      };

  String toJson() => jsonEncode(toMap());
}
