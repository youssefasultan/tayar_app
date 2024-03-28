import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  const OrderRemoteDataSource();

  Future<List<OrderModel>> getOrder({
    required String orgId,
    required String driverId,
  });

  Future<void> updateOrderStatus({
    required String orgId,
    required String orderId,
    required String status,
    required int cancelReason,
    required String driverId,
    required String note,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl(this._client);

  final http.Client _client;

  // A function that retrieves a list of orders for a specific organization and driver.
  // Requires the organization ID and driver ID as parameters.
  // Returns a Future containing a list of OrderModel objects.
  @override
  Future<List<OrderModel>> getOrder({
    required String orgId,
    required String driverId,
  }) async {
    try {
      final response = await _client.get(
        Uri.http(
          kBaseUrl,
          kGetOrdersEndPoint,
          buildGetEndPointParams(
            orgId,
            driverId,
          ),
        ),
        headers: kHeader,
      );

      if (response.statusCode != 200) {
        final resposneData = jsonDecode(response.body) as DataMap;

        throw ServerException(
          message: resposneData['message'] as String,
          statusCode: int.parse(resposneData['rCode'] as String),
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(OrderModel.fromMap)
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  // Updates the order status with the provided information.
  // Parameters:
  //   - orgId: the organization ID
  //   - orderId: the order ID
  //   - status: the status to update to
  //   - cancelReason: the cancel reason
  //   - driverId: the driver ID
  //   - note: a note related to the status update
  Future<void> updateOrderStatus({
    required String orgId,
    required String orderId,
    required String status,
    required int cancelReason,
    required String driverId,
    required String note,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(
          kBaseUrl,
          kUpdateOrderStatus,
        ),
        headers: kHeader,
        body: jsonEncode({
          'OrgId': orgId,
          'OrderNo': orderId,
          'Status': status,
          'ReasonId': 0,
          'Note': note,
          'DriverId': driverId,
        }),
      );
      final responseData = json.decode(response.body) as DataMap;
      if ((responseData['rCode'] as int) != 200) {
        throw ServerException(
          message: responseData['message'] as String,
          statusCode: responseData['rcode'] as int,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
