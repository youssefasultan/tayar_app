import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/orders/domain/usecases/update_order_status.dart';

import 'orders_repo.mock.dart';

void main() {
  late MockOrdersRepo repo;
  late UpdateOrderStatus usecase;

  setUp(() {
    repo = MockOrdersRepo();
    usecase = UpdateOrderStatus(repo);
  });

  const tUpdateOrderStatusParam = UpdateOrderParams.empty();

  test('should call [UpdateOderStatus]', () async {
    when(
      () => repo.updateOrderStatus(
        orgId: any(named: 'orgId'),
        orderId: any(named: 'orderId'),
        status: any(named: 'status'),
        cancelReason: any(named: 'cancelReason'),
        driverId: any(named: 'driverId'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(tUpdateOrderStatusParam);

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.updateOrderStatus(
        orgId: tUpdateOrderStatusParam.orgId,
        orderId: tUpdateOrderStatusParam.orderId,
        status: tUpdateOrderStatusParam.status,
        cancelReason: tUpdateOrderStatusParam.cancelReason,
        driverId: tUpdateOrderStatusParam.driverId,
        note: tUpdateOrderStatusParam.note,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
