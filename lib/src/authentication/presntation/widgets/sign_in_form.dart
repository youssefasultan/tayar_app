// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/app_text_feild.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.teleponeNoController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController teleponeNoController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextFeild(
            controller: widget.teleponeNoController,
            hintText: AppLocale.telephoneNo.getString(context),
            keyboardType: TextInputType.phone,
            filled: true,
            filledColor: Colors.white,
            validator: (value) {
              if (value!.length < 11) {
                return AppLocale.phoneLengthError.getString(context);
              }
              return null;
            },
          ),
          SizedBox(height: 25.h),
          AppTextFeild(
            controller: widget.passwordController,
            hintText: AppLocale.password.getString(context),
            obsecure: obsecurePassword,
            keyboardType: TextInputType.visiblePassword,
            filled: true,
            filledColor: Colors.white,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obsecurePassword = !obsecurePassword;
              }),
              icon: Icon(
                obsecurePassword ? Icons.visibility : Icons.visibility_off,
                color: kBlue,
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
