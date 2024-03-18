import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    required this.color,
    required this.child,
    required this.width,
    required this.height,
    required this.imgPath,
    super.key,
  });

  final Color color;
  final Widget child;
  final double width;
  final double height;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
