import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_app/core/common/app/providers/orders_provider.dart';
import 'package:tayar_app/core/common/app/providers/report_provider.dart';
import 'package:tayar_app/core/common/app/providers/tab_navigator.dart';
import 'package:tayar_app/core/common/app/providers/user_provider.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  UserEntity? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();

  OrdersProvider get orderProvider => read<OrdersProvider>();
  ReportProvider get reportProvider => read<ReportProvider>();

  void pop() => tabNavigator.pop();
  void popToHome() => tabNavigator.popToRoot();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
