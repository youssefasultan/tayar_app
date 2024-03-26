import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/background_containder.dart';
import 'package:tayar_app/core/common/widgets/rounded_button.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';
import 'package:tayar_app/src/authentication/presntation/widgets/create_password_alert_dialog.dart';
import 'package:tayar_app/src/authentication/presntation/widgets/lang_dropdown.dart';
import 'package:tayar_app/src/authentication/presntation/widgets/sign_in_form.dart';
import 'package:tayar_app/src/dashboard/presntation/view/dashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final telephoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    telephoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (_, state) {
          return BackgroundContainer(
            color: kBlack,
            width: width,
            height: height,
            imgPath: 'assets/images/login_bg.jpg',
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.fill,
                    width: 200.w,
                    height: 300.h,
                  ),
                  SizedBox(height: 20.h),
                  SignInForm(
                    teleponeNoController: telephoneNoController,
                    passwordController: passwordController,
                    formKey: formKey,
                  ),
                  SizedBox(height: 30.h),
                  if (state is AuthLoading)
                    const Center(
                      child: SpinKitFadingCube(
                        color: kOrange,
                      ),
                    )
                  else
                    RoundedButton(
                      label: AppLocale.signIn.getString(context),
                      buttonColor: kBeige,
                      labelColor: kBlack,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignInEvent(
                                  telephoneNo:
                                      telephoneNoController.text.trim(),
                                  password: passwordController.text.trim(),
                                  orgId: kOrgId,
                                ),
                              );
                        }
                      },
                    ),
                  SizedBox(height: 30.h),
                  const Align(
                    alignment: Alignment.topRight,
                    child: LangDropDown(),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedInWithoutInit) {
            context.userProvider.initUser(state.user as UserModel);

            Navigator.pushReplacementNamed(
              context,
              DashBoardScreen.routeName,
            );
          } else if (state is SignedInWithInit) {
            context.userProvider.initUser(state.user as UserModel);
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const CreatePasswordAlertDialog(),
              ),
            );
          }
        },
      ),
    );
  }
}
