import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/repos/orders_repo.dart';

class GetOrders extends UsecaseWithParams<List<OrderEntity>, GetOrdersParams> {
  const GetOrders(this._repo);

  final OrdersRepo _repo;
  @override
  ResultFuture<List<OrderEntity>> call(GetOrdersParams params) =>
      _repo.getOrders(orgId: params.orgId, driverId: params.driverId);
}

class GetOrdersParams extends Equatable {
  const GetOrdersParams({required this.driverId, required this.orgId});

  const GetOrdersParams.empty() : this(driverId: '', orgId: '');

  final String driverId;
  final String orgId;
  @override
  List<Object?> get props => [driverId];
}
