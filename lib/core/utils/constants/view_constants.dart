import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/utils/constants/enum_constants.dart';

double height = 825.h;
double width = 375.w;

const kBlue = Color.fromRGBO(52, 104, 192, 1);
const kLightBlue = Color.fromRGBO(134, 167, 252, 1);
const kBeige = Color(0xFFE0BD74);
const kOrange = Color(0xFFE0BD74);

const kBlack = Color(0xff191718);

LinearGradient kLinerGradient(OrderStatus status) => LinearGradient(
      colors: getStatusGadient(status),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0, 1],
    );

List<Color> getStatusGadient(OrderStatus status) {
  switch (status) {
    case OrderStatus.NEW:
      return [
        const Color(0xFF00B4DB),
        const Color(0xFF0083B0),
      ];

    case OrderStatus.INPROCESS:
      return [
        const Color(0xFFCAC531),
        const Color(0xFFf3f9a7),
      ];

    case OrderStatus.DELIVERED:
      return [
        const Color(0xFF38ef7d),
        const Color(0xFF11998e),
      ];

    case OrderStatus.CANCELLED:
      return [
        const Color(0xFFe35d5b),
        const Color(0xFFe53935),
      ];
  }
}

const loginImgPath = 'assets/images/login_bg.jpg';
const bannerImgPath = 'assets/images/banner_img.jpg';
