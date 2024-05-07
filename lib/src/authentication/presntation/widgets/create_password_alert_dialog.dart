import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/app_text_feild.dart';
import 'package:tayar_app/core/common/widgets/rounded_button.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';
import 'package:tayar_app/src/dashboard/presntation/view/dashboard_screen.dart';

class CreatePasswordAlertDialog extends StatefulWidget {
  const CreatePasswordAlertDialog({super.key});

  @override
  State<CreatePasswordAlertDialog> createState() =>
      _CreatePasswordAlertDialogState();
}

class _CreatePasswordAlertDialogState extends State<CreatePasswordAlertDialog> {
  final passTFController = TextEditingController();
  final confrimPassTFController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool newPassObsecure = true;
  bool confrimPassObsecure = true;

  @override
  void dispose() {
    passTFController.dispose();
    confrimPassTFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (_, state) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(vertical: 50.h),
          alignment: Alignment.center,
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFeild(
                  controller: passTFController,
                  hintText: AppLocale.password.getString(context),
                  keyboardType: TextInputType.visiblePassword,
                  filled: true,
                  filledColor: Colors.white,
                  obsecure: newPassObsecure,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      newPassObsecure = !newPassObsecure;
                    }),
                    icon: Icon(
                      newPassObsecure ? Icons.visibility : Icons.visibility_off,
                      color: kBlack,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextFeild(
                  controller: confrimPassTFController,
                  hintText: AppLocale.confirmNewPassword.getString(context),
                  keyboardType: TextInputType.visiblePassword,
                  obsecure: confrimPassObsecure,
                  filled: true,
                  filledColor: Colors.white,
                  validator: (value) {
                    if (value!.trim() != passTFController.text.trim()) {
                      return AppLocale.createPassError.getString(context);
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      confrimPassObsecure = !confrimPassObsecure;
                    }),
                    icon: Icon(
                      confrimPassObsecure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kBlack,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 20.h,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            if (state is AuthLoading)
              const Center(
                child: SpinKitThreeBounce(
                  color: kOrange,
                ),
              )
            else
              RoundedButton(
                label: AppLocale.createPass.getString(context),
                buttonColor: kBeige,
                labelColor: kBlack,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          CreatePasswordEvent(
                            user: context.currentUser! as UserModel,
                            newPassword: passTFController.text.trim(),
                          ),
                        );
                  }
                },
              ),
          ],
        );
      },
      listener: (_, state) {
        if (state is AuthError) {
          Navigator.of(context).pop();
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CreatePasswordSent) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(
            context,
            DashBoardScreen.routeName,
          );
          CoreUtils.showSuccessSnackBar(
            context,
            AppLocale.successfully.getString(context),
          );
        }
      },
    );
  }
}
