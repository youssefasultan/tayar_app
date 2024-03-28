import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    required this.color,
    required this.child,
    required this.width,
    required this.height,
    required this.imgPath,
    required this.radiusGeometry,
    super.key,
  });

  final Color color;
  final Widget child;
  final double width;
  final double height;
  final String imgPath;
  final BorderRadiusGeometry radiusGeometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radiusGeometry,
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
