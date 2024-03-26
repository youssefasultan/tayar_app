// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class AppTextFeild extends StatelessWidget {
  const AppTextFeild({
    required this.controller,
    super.key,
    this.validator,
    this.filled = false,
    this.filledColor,
    this.obsecure = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.overrideValidator = false,
    this.hintTextStyle,
    this.formattors,
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
  final List<TextInputFormatter>? formattors;

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
      inputFormatters: formattors,
      keyboardType: keyboardType,
      obscureText: obsecure,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kBlack),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.r),
          borderSide: const BorderSide(color: kBlack),
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
              color: kBlack,
            ),
      ),
    );
  }
}
