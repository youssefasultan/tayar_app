import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/usecases/get_orders.dart';
import 'package:tayar_app/src/orders/domain/usecases/update_order_status.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';

class MockGetOrders extends Mock implements GetOrders {}

class MockUpdateOrderStatus extends Mock implements UpdateOrderStatus {}

void main() {
  late GetOrders getOrders;
  late UpdateOrderStatus updateOrderStatus;
  late OrderBloc orderBloc;

  const tGetOrdersParams = GetOrdersParams.empty();
  const tUpdateOrderStatusParams = UpdateOrderParams.empty();
  const tServerFailure = ServerFailure(
    message: 'orders-not-found',
    statusCode: 'there is no user recored',
  );

  setUp(() {
    getOrders = MockGetOrders();
    updateOrderStatus = MockUpdateOrderStatus();
    orderBloc =
        OrderBloc(getOrders: getOrders, updateOrderStatus: updateOrderStatus);
  });

  setUpAll(() {
    registerFallbackValue(tGetOrdersParams);
    registerFallbackValue(tUpdateOrderStatusParams);
    registerFallbackValue(tServerFailure);
  });

  tearDown(() => orderBloc.close());

  test('initialState should be [OrderInitial]', () {
    expect(orderBloc.state, const OrderInitial());
  });

  group('Get Orders Event', () {
    final tOrderList = [OrderEntity.empty()];
    blocTest<OrderBloc, OrderState>(
      'should emit [GettingOrders, OrdersLoaded] '
      'when [GetOrdersEvent] is added',
      build: () {
        when(
          () => getOrders(any()),
        ).thenAnswer((_) async => Right(tOrderList));
        return orderBloc;
      },
      act: (bloc) => bloc.add(
        GetOrdersEvent(
          tGetOrdersParams.orgId,
          tGetOrdersParams.driverId,
        ),
      ),
      expect: () => [
        const GettingOrders(),
        OrdersLoaded(tOrderList),
      ],
      verify: (_) {
        verify(
          () => getOrders(tGetOrdersParams),
        ).called(1);
        verifyNoMoreInteractions(getOrders);
      },
    );

    blocTest<OrderBloc, OrderState>(
      'Should emit [GettingOrders, OrderError] when getOrders fails',
      build: () {
        when(
          () => getOrders(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));
        return orderBloc;
      },
      act: (bloc) => bloc.add(
        GetOrdersEvent(
          tGetOrdersParams.orgId,
          tGetOrdersParams.driverId,
        ),
      ),
      expect: () => [
        const GettingOrders(),
        OrderError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => getOrders(tGetOrdersParams),
        ).called(1);
        verifyNoMoreInteractions(getOrders);
      },
    );
  });

  group('Update Order Status event', () {
    blocTest<OrderBloc, OrderState>(
      'should emit [UpdatingOrderStatus, OrderStatusUpdated] when '
      '[UpdateOrderStatus] is added',
      build: () {
        when(
          () => updateOrderStatus(any()),
        ).thenAnswer((_) async => const Right(null));
        return orderBloc;
      },
      act: (bloc) => bloc.add(
        UpdateOrderEvent(
          tUpdateOrderStatusParams.orgId,
          tUpdateOrderStatusParams.orderId,
          tUpdateOrderStatusParams.status,
          tUpdateOrderStatusParams.cancelReason,
          tUpdateOrderStatusParams.driverId,
          tUpdateOrderStatusParams.note,
        ),
      ),
      expect: () => [
        const UpdatingOrderStatus(),
        const OrderStatusUpdated(),
      ],
      verify: (_) {
        verify(
          () => updateOrderStatus(tUpdateOrderStatusParams),
        ).called(1);
        verifyNoMoreInteractions(updateOrderStatus);
      },
    );

    blocTest<OrderBloc, OrderState>(
      'Should emit [UpdatingOrderStatus, OrderError] when '
      'updateOrderStatus fails',
      build: () {
        when(
          () => updateOrderStatus(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));
        return orderBloc;
      },
      act: (bloc) => bloc.add(
        UpdateOrderEvent(
          tUpdateOrderStatusParams.orgId,
          tUpdateOrderStatusParams.orderId,
          tUpdateOrderStatusParams.status,
          tUpdateOrderStatusParams.cancelReason,
          tUpdateOrderStatusParams.driverId,
          tUpdateOrderStatusParams.note,
        ),
      ),
      expect: () => [
        const UpdatingOrderStatus(),
        OrderError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => updateOrderStatus(tUpdateOrderStatusParams),
        ).called(1);
        verifyNoMoreInteractions(updateOrderStatus);
      },
    );
  });
}
