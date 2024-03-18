import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double height = 825.h;
double width = 375.w;

const kBlue = Color.fromRGBO(52, 104, 192, 1);
const kLightBlue = Color.fromRGBO(134, 167, 252, 1);
const kBeige = Color.fromRGBO(255, 221, 149, 1);
const kOrange = Color.fromRGBO(255, 152, 67, 1);

final LinearGradient kLinerGradient = LinearGradient(
  colors: [
    kLightBlue.withOpacity(0.5),
    kBeige,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const [0, 1],
);

const loginImgPath = 'assets/images/login_bg.jpg';
const bannerImgPath = 'assets/images/banner_img.jpg';
