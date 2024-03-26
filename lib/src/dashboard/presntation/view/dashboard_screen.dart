import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/dashboard/presntation/providers/dashboard_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (_, controller, __) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: controller.screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            elevation: 8,
            onTap: controller.changeIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: controller.currentIndex == 0 ? kBeige : kBlack,
                ),
                label: 'Orders',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: controller.currentIndex == 1 ? kBeige : kBlack,
                ),
                label: 'profile',
                backgroundColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
