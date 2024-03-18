import 'package:flutter/material.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';
import 'package:tayar_app/src/orders/data/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderModel>? _orderList;
  OrderModel? _inProcessOrder;

  List<OrderModel>? get orderList => _orderList;
  OrderModel? get inProcessOrder => _inProcessOrder;

  void init(List<OrderModel>? orderList) {
    if (_orderList != null) _orderList!.clear();
    _orderList = orderList;
    _inProcessOrder = getInProcessOrder();
    Future.delayed(Duration.zero, notifyListeners);
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

  OrderModel? getInProcessOrder() {
    try {
      return _orderList!.firstWhere(
        (element) => element.status == OrderStatus.INPROCESS,
        orElse: () => throw Exception(),
      );
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
