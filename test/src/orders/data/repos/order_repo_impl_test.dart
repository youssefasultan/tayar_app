import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/orders/data/datasources/remote/order_remote_data_source.dart';
import 'package:tayar_app/src/orders/data/repos/order_repo_impl.dart';
import 'package:tayar_app/src/orders/domain/entities/order_entity.dart';
import 'package:tayar_app/src/orders/domain/usecases/get_orders.dart';
import 'package:tayar_app/src/orders/domain/usecases/update_order_status.dart';

class MockOrderRemoteDataSource extends Mock implements OrderRemoteDataSource {}

void main() {
  late OrderRepoImpl repoImpl;
  late OrderRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockOrderRemoteDataSource();
    repoImpl = OrderRepoImpl(remoteDataSource);
  });

  const tException = ServerException(message: 'Not found', statusCode: 500);

  group('get orders', () {
    const tGetOrdersParams = GetOrdersParams.empty();

    test(
      'Should call [OrderRemoteDataSource.GetOrders] and'
      ' Return list of [OrderModel] when successfull',
      () async {
        when(
          () => remoteDataSource.getOrder(
            orgId: any(named: 'orgId'),
            driverId: any(named: 'driverId'),
          ),
        ).thenAnswer((_) async => []);

        final result = await repoImpl.getOrders(
          orgId: tGetOrdersParams.orgId,
          driverId: tGetOrdersParams.driverId,
        );

        expect(result, isA<Right<dynamic, List<OrderEntity>>>());
        verify(
          () => remoteDataSource.getOrder(
            orgId: tGetOrdersParams.orgId,
            driverId: tGetOrdersParams.driverId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'Should return [ServerFailure] when call to '
      '[OrderRemoteDataSource.getOrders] is unsuccessfull',
      () async {
        when(
          () => remoteDataSource.getOrder(
            orgId: any(named: 'orgId'),
            driverId: any(named: 'driverId'),
          ),
        ).thenThrow(tException);

        final result = await repoImpl.getOrders(
          orgId: tGetOrdersParams.orgId,
          driverId: tGetOrdersParams.driverId,
        );

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.getOrder(
            orgId: tGetOrdersParams.orgId,
            driverId: tGetOrdersParams.driverId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('Update Order Status', () {
    const tUpdateOrderStatusParams = UpdateOrderParams.empty();
    test(
      'should call [RemoteDataSource.UpdateOrderStatus] and complete '
      'successfully when the call to the remote source is successfull',
      () async {
        when(
          () => remoteDataSource.updateOrderStatus(
            orgId: any(named: 'orgId'),
            orderId: any(named: 'orderId'),
            status: any(named: 'status'),
            cancelReason: any(named: 'cancelReason'),
            driverId: any(named: 'driverId'),
            note: any(named: 'note'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.updateOrderStatus(
          orgId: tUpdateOrderStatusParams.orgId,
          orderId: tUpdateOrderStatusParams.orderId,
          status: tUpdateOrderStatusParams.status,
          cancelReason: tUpdateOrderStatusParams.cancelReason,
          driverId: tUpdateOrderStatusParams.driverId,
          note: tUpdateOrderStatusParams.note,
        );

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.updateOrderStatus(
            orgId: tUpdateOrderStatusParams.orgId,
            orderId: tUpdateOrderStatusParams.orderId,
            status: tUpdateOrderStatusParams.status,
            cancelReason: tUpdateOrderStatusParams.cancelReason,
            driverId: tUpdateOrderStatusParams.driverId,
            note: tUpdateOrderStatusParams.note,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'Should return [ServerFailure] when call to '
      '[OrderRemoteDataSource.updateOrderSatus] is unsuccessfull',
      () async {
        when(
          () => remoteDataSource.updateOrderStatus(
            orgId: any(named: 'orgId'),
            orderId: any(named: 'orderId'),
            status: any(named: 'status'),
            cancelReason: any(named: 'cancelReason'),
            driverId: any(named: 'driverId'),
            note: any(named: 'note'),
          ),
        ).thenThrow(tException);

        final result = await repoImpl.updateOrderStatus(
          orgId: tUpdateOrderStatusParams.orgId,
          orderId: tUpdateOrderStatusParams.orderId,
          status: tUpdateOrderStatusParams.status,
          cancelReason: tUpdateOrderStatusParams.cancelReason,
          driverId: tUpdateOrderStatusParams.driverId,
          note: tUpdateOrderStatusParams.note,
        );

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.updateOrderStatus(
            orgId: tUpdateOrderStatusParams.orgId,
            orderId: tUpdateOrderStatusParams.orderId,
            status: tUpdateOrderStatusParams.status,
            cancelReason: tUpdateOrderStatusParams.cancelReason,
            driverId: tUpdateOrderStatusParams.driverId,
            note: tUpdateOrderStatusParams.note,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
