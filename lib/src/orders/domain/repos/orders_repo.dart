import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';

abstract class OrdersRepo {
  const OrdersRepo();

  ResultFuture<List<OrderEntity>> getOrders({
    required String orgId,
    required String driverId,
  });

  ResultFuture<void> updateOrderStatus({
    required String orgId,
    required String orderId,
    required String status,
    required int cancelReason,
    required String driverId,
    required String note,
  });
}
