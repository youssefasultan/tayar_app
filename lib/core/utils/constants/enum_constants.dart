// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

enum OrderStatus {
  NEW(
    1,
    'I',
    kBlue,
    Ionicons.archive,
    AppLocale.neW,
  ),
  INPROCESS(
    2,
    'O',
    kOrange,
    Ionicons.walk,
    AppLocale.inProcess,
  ),
  DELIVERED(
    3,
    'D',
    Colors.green,
    Ionicons.checkmark_done,
    AppLocale.delivered,
  ),
  CANCELLED(
    4,
    'C',
    Colors.red,
    Icons.cancel,
    AppLocale.cancelled,
  );

  const OrderStatus(this.id, this.code, this.statusColor, this.icon, this.name);

  final int id;
  final String code;
  final Color statusColor;
  final IconData icon;
  final String name;

  static List<OrderStatus> getAllStatusesExceptInProcess() {
    return OrderStatus.values
        .where((status) => status != OrderStatus.INPROCESS)
        .toList();
  }
}

enum PaymentType {
  CASH('Cash', AppLocale.cash),
  VISA('Visa', AppLocale.card);

  const PaymentType(this.name, this.locale);

  final String name;
  final String locale;
}
