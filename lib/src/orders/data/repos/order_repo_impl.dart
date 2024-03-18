import 'package:dartz/dartz.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/datasources/remote/order_remote_data_source.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/repos/orders_repo.dart';

class OrderRepoImpl implements OrdersRepo {
  OrderRepoImpl(this._remoteDataSource);

  final OrderRemoteDataSource _remoteDataSource;
  @override
  ResultFuture<List<OrderEntity>> getOrders({
    required String orgId,
    required String driverId,
  }) async {
    try {
      final result = await _remoteDataSource.getOrder(
        orgId: orgId,
        driverId: driverId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultFuture<void> updateOrderStatus({
    required String orgId,
    required String orderId,
    required String status,
    required int cancelReason,
    required String driverId,
    required String note,
  }) async {
    try {
      await _remoteDataSource.updateOrderStatus(
        orgId: orgId,
        orderId: orderId,
        status: status,
        cancelReason: cancelReason,
        driverId: driverId,
        note: note,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }
}
