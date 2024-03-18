import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutLinedText extends StatelessWidget {
  const OutLinedText({
    required this.label,
    required this.labelSize,
    required this.fontWeight,
    required this.strokeWidth,
    required this.strokeColor,
    required this.textColor,
    super.key,
  });

  final String label;
  final double labelSize;
  final FontWeight fontWeight;
  final double strokeWidth;
  final Color strokeColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelSize.sp,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: labelSize.sp,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
