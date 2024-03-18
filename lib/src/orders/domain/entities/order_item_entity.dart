import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  const OrderItemEntity({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.uom,
  });

  const OrderItemEntity.empty()
      : this(
          itemId: 0,
          itemName: '',
          quantity: 0,
          uom: '',
        );

  final int itemId;
  final String itemName;
  final int quantity;
  final String uom;

  @override
  List<Object?> get props => [itemId, itemName, quantity];

  @override
  String toString() =>
      'OrderItem(id: $itemId, name: $itemName, qty: $quantity, uom: $uom)';
}
