import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.userProvider.user!;
    return Container(
      width: width,
      height: height * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                CircleAvatar(
                  backgroundColor: kBeige,
                  radius: 50.r,
                  child: Icon(
                    Ionicons.person,
                    color: kBlack,
                    size: 50.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: kBlack,
            thickness: 2.h,
            endIndent: 20.w,
            indent: 20.w,
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Ionicons.car,
                    color: kBeige,
                    size: 40.h,
                  ),
                  Text(
                    AppLocale.vehicleNo.getString(context),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kBlack,
                    ),
                  ),
                  Text(
                    user.vehicleNo,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Ionicons.phone_portrait,
                    color: kBeige,
                    size: 40.h,
                  ),
                  Text(
                    AppLocale.telephoneNo.getString(context),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kBlack,
                    ),
                  ),
                  Text(
                    user.phoneNo,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
