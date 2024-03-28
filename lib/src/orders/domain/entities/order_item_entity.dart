import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  const OrderItemEntity({
    required this.itemId,
    required this.itemNameEn,
    required this.itemNameAr,
    required this.quantity,
    required this.uomEn,
    required this.uomAr,
  });

  const OrderItemEntity.empty()
      : this(
          itemId: 0,
          itemNameEn: '',
          itemNameAr: '',
          quantity: 0,
          uomEn: '',
          uomAr: '',
        );

  final int itemId;
  final String itemNameEn;
  final String itemNameAr;
  final int quantity;
  final String uomEn;
  final String uomAr;

  @override
  List<Object?> get props => [itemId, itemNameEn, quantity];

  @override
  String toString() =>
      'OrderItem(id: $itemId, nameEn: $itemNameEn, nameAr: $itemNameAr, '
      'qty: $quantity, uomEn: $uomEn, uomAr: $uomAr)';
}
