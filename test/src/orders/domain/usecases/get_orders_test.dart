import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/usecases/get_orders.dart';

import 'orders_repo.mock.dart';

void main() {
  late MockOrdersRepo repo;
  late GetOrders usecase;

  setUp(() {
    repo = MockOrdersRepo();
    usecase = GetOrders(repo);
  });

  final tOrderList = [OrderEntity.empty()];
  const tGetOrderParams = GetOrdersParams.empty();

  test('Should return [List<OrderEntity>] from [OrdersRepo]', () async {
    when(
      () => repo.getOrders(
        orgId: any(named: 'orgId'),
        driverId: any(named: 'driverId'),
      ),
    ).thenAnswer((_) async => Right(tOrderList));

    final result = await usecase(tGetOrderParams);

    expect(result, Right<dynamic, List<OrderEntity>>(tOrderList));

    verify(
      () => repo.getOrders(
        orgId: tGetOrderParams.orgId,
        driverId: tGetOrderParams.driverId,
      ),
    ).called(1);

    verifyNoMoreInteractions(repo);
  });
}
