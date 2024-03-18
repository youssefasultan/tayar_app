import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/src/orders/data/datasources/remote/order_remote_data_source.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';
import 'package:tayar_app/src/orders/domain/usecases/get_orders.dart';
import 'package:tayar_app/src/orders/domain/usecases/update_order_status.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late OrderRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = OrderRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  const tException = ServerException(message: 'Not found', statusCode: 500);

  group('get orders', () {
    final tOrders = [OrderModel.empty()];
    const tGetOrdersParams = GetOrdersParams.empty();
    test('Should return a list of [OrderModel] when status is 200', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode([tOrders.first.toMap()]),
          200,
        ),
      );

      final result = await remoteDataSource.getOrder(
        orgId: tGetOrdersParams.orgId,
        driverId: tGetOrdersParams.driverId,
      );

      expect(result, equals(tOrders));

      verify(
        () => client.get(
          Uri.http(
            kBaseUrl,
            kGetOrdersEndPoint,
            buildGetEndPointParams(
              tGetOrdersParams.orgId,
              tGetOrdersParams.driverId,
            ),
          ),
          headers: kHeader,
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw [ServerException] when status code is not 200 or 201',
        () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(tException);

      final methodCall = remoteDataSource.getOrder;

      expect(
        () async => methodCall(
          orgId: tGetOrdersParams.orgId,
          driverId: tGetOrdersParams.driverId,
        ),
        throwsA(
          ServerException(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );

      verify(
        () => client.get(
          Uri.http(
            kBaseUrl,
            kGetOrdersEndPoint,
            buildGetEndPointParams(
              tGetOrdersParams.orgId,
              tGetOrdersParams.driverId,
            ),
          ),
          headers: kHeader,
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('update order status', () {
    const tUpdateOrderStatusParams = UpdateOrderParams.empty();
    test('Should return sucessfully when status is 200', () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            {
              'message': 'Order number 1 is in proccess',
              'rCode': 200,
            },
          ),
          200,
        ),
      );

      final methodCall = remoteDataSource.updateOrderStatus;

      expect(
        methodCall(
          orderId: tUpdateOrderStatusParams.orderId,
          cancelReason: tUpdateOrderStatusParams.cancelReason,
          driverId: tUpdateOrderStatusParams.driverId,
          note: tUpdateOrderStatusParams.note,
          orgId: tUpdateOrderStatusParams.orgId,
          status: tUpdateOrderStatusParams.status,
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kUpdateOrderStatus,
          ),
          headers: kHeader,
          body: jsonEncode({
            'OrgId': tUpdateOrderStatusParams.orgId,
            'OrderNo': tUpdateOrderStatusParams.orderId,
            'Status': tUpdateOrderStatusParams.status,
            'ReasonId': tUpdateOrderStatusParams.cancelReason,
            'Note': tUpdateOrderStatusParams.note,
            'DriverId': tUpdateOrderStatusParams.driverId,
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('Should throw [ServerException] when status code is not 200 or 201',
        () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenThrow(tException);

      final methodCall = remoteDataSource.updateOrderStatus;

      expect(
        () async => methodCall(
          orderId: tUpdateOrderStatusParams.orderId,
          cancelReason: tUpdateOrderStatusParams.cancelReason,
          driverId: tUpdateOrderStatusParams.driverId,
          note: tUpdateOrderStatusParams.note,
          orgId: tUpdateOrderStatusParams.orgId,
          status: tUpdateOrderStatusParams.status,
        ),
        throwsA(
          ServerException(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kUpdateOrderStatus,
          ),
          headers: kHeader,
          body: jsonEncode({
            'OrgId': tUpdateOrderStatusParams.orgId,
            'OrderNo': tUpdateOrderStatusParams.orderId,
            'Status': tUpdateOrderStatusParams.status,
            'ReasonId': tUpdateOrderStatusParams.cancelReason,
            'Note': tUpdateOrderStatusParams.note,
            'DriverId': tUpdateOrderStatusParams.driverId,
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
