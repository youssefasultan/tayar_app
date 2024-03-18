import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/domain/repos/orders_repo.dart';

class UpdateOrderStatus extends UsecaseWithParams<void, UpdateOrderParams> {
  UpdateOrderStatus(this._repo);

  final OrdersRepo _repo;
  @override
  ResultFuture<void> call(UpdateOrderParams params) => _repo.updateOrderStatus(
        orgId: params.orgId,
        orderId: params.orderId,
        status: params.status,
        cancelReason: params.cancelReason,
        driverId: params.driverId,
        note: params.note,
      );
}

class UpdateOrderParams extends Equatable {
  const UpdateOrderParams({
    required this.orgId,
    required this.orderId,
    required this.status,
    required this.cancelReason,
    required this.driverId,
    required this.note,
  });

  const UpdateOrderParams.empty()
      : this(
          orderId: '',
          orgId: '',
          status: 'I',
          cancelReason: 0,
          driverId: '',
          note: '',
        );

  final String orgId;
  final String orderId;
  final String status;
  final int cancelReason;
  final String driverId;
  final String note;

  @override
  List<Object?> get props => [orderId, status];
}
