import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderModel>? _orderList;
  List<OrderModel>? _inProcessOrderList;

  List<OrderModel>? get orderList => _orderList;
  List<OrderModel>? get inProcessOrder => _inProcessOrderList;


  void init(List<OrderModel>? orderList) {
    if (_orderList != null) _orderList!.clear();
    _orderList = orderList;
    _inProcessOrderList = getInProcessOrder();
    Future.delayed(Duration.zero, notifyListeners);
  }

  final localization = FlutterLocalization.instance;

  Future<List<DataMap>?> getCancelReasons() async {
    final response = await http.get(
      Uri.http(
        kBaseUrl,
        kGetCancelReasonsEndPoint,
      ),
      headers: kHeader,
    );

    final responseData = json.decode(response.body) as List<dynamic>;

    final cancelReasons = responseData
        .map(
          (e) => {
            'id': (e as DataMap)['id'],
            'reason': localization.currentLocale!.languageCode == 'en'
                ? e['reason_En']
                : e['reason_Ar'],
          },
        )
        .toList();

    cancelReasons.add({
      'id': 0,
      'reason':
          localization.currentLocale!.languageCode == 'en' ? 'Other' : 'أخري',
    });

    return cancelReasons;
  }

  double getCollectedCash() {
    try {
      return _orderList!.fold(0, (previousValue, element) {
        if (element.paymentType == PaymentType.CASH &&
            element.status == OrderStatus.DELIVERED) {
          return previousValue + element.totalAmount;
        }
        return previousValue;
      });
    } catch (e) {
      return 0;
    }
  }

  double getExpectedCash() {
    try {
      return _orderList!.fold(0, (previousValue, element) {
        if (element.paymentType == PaymentType.CASH) {
          return previousValue + element.totalAmount;
        }
        return previousValue;
      });
    } catch (e) {
      return 0;
    }
  }

  int getNoOfCashOrders() {
    try {
      return _orderList!
          .where((element) => element.paymentType == PaymentType.CASH)
          .toList()
          .length;
    } catch (e) {
      return 0;
    }
  }

  int getdeliveredCashOrders() {
    try {
      return _orderList!
          .where(
            (element) =>
                element.paymentType == PaymentType.CASH &&
                element.status == OrderStatus.DELIVERED,
          )
          .toList()
          .length;
    } catch (e) {
      return 0;
    }
  }

  int getNoOfOrdersPerStatus(OrderStatus status) {
    try {
      return _orderList!
          .where((element) => element.status == status)
          .toList()
          .length;
    } catch (e) {
      return 0;
    }
  }

  List<OrderModel>? getInProcessOrder() {
    try {
      return _orderList!
          .where((element) => element.status == OrderStatus.INPROCESS)
          .toList();
    } catch (e) {
      return null;
    }
  }

  List<OrderModel>? getOrdersPerStatus(OrderStatus status) {
    try {
      return _orderList!
          .where(
            (element) => element.status == status,
          )
          .toList();
    } catch (e) {
      return null;
    }
  }
}
