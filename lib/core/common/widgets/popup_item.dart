import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({
    required this.label,
    required this.icon,
    super.key,
  });

  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: kBlack,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon,
      ],
    );
  }
}
