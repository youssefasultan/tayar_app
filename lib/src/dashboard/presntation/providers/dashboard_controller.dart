import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tayar_app/core/common/app/providers/tab_navigator.dart';
import 'package:tayar_app/core/common/widgets/presistant_view.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';
import 'package:tayar_app/src/orders/presentation/bloc/order_bloc.dart';
import 'package:tayar_app/src/orders/presentation/view/home_screen.dart';
import 'package:tayar_app/src/profile/presentation/views/profile_view.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (context) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (context) => sl<OrderBloc>(),
            child: const HomeScreen(),
          ),
        ),
      ),
      child: const PresistantView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const ProfileView(),
          ),
        ),
      ),
      child: const PresistantView(),
    ),
  ];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void restIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
