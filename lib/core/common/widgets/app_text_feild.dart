import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class AppTextFeild extends StatelessWidget {
  const AppTextFeild({
    required this.controller,
    this.filled = false,
    this.obsecure = false,
    this.readOnly = false,
    this.overrideValidator = false,
    this.validator,
    this.filledColor,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintTextStyle,
    super.key,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? filledColor;
  final bool obsecure;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintTextStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return AppLocale.requiredFeild.getString(context);
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      obscureText: obsecure,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kLightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kLightBlue),
        ),
        filled: filled,
        fillColor: filledColor,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kOrange),
        ),
        errorStyle: const TextStyle(
          color: kOrange,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kOrange),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: kBlue,
            ),
      ),
    );
  }
}
