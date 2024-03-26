import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/widgets/nested_back_button.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class OrdersPerStatusAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrdersPerStatusAppBar({
    required this.status,
    super.key,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const NestedbackButton(),
      title: Text(
        status,
        style: TextStyle(
          fontSize: 24.sp,
          color: kBlack,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
