import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/rounded_button.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.all(10.w),
        ),
      );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.all(10.w),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: kBlack.withOpacity(0.7),
          elevation: 3,
          icon: const SpinKitPouringHourGlass(
            color: Colors.white,
          ),
          content: Text(
            AppLocale.loading.getString(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static Future<DataMap?> showCancelReasonDialog(
    BuildContext context,
    String orderId,
  ) {
    final tfController = TextEditingController();

    return showDialog<DataMap?>(
      context: context,
      builder: (_) => FutureBuilder(
        future: context.orderProvider.getCancelReasons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCube(
                color: kOrange,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }

          var selectedReason = snapshot.data![0];
          var validate = false;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  AppLocale.reason.getString(context),
                  textAlign: TextAlign.center,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: kBlack,
                ),
                content: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(snapshot.data!.length, (index) {
                        final reason = snapshot.data![index];
                        return RadioListTile(
                          title: Text(
                            reason['reason'] as String,
                          ),
                          activeColor: kBlack,
                          value: reason,
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() => selectedReason = value!);
                          },
                        );
                      }),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        width: width,
                        height: selectedReason['id'] == 0 ? 60.h : 0,
                        child: TextField(
                          controller: tfController,
                          decoration: InputDecoration(
                            hintText: AppLocale.enterReason.getString(context),
                            border: const UnderlineInputBorder(),
                            errorText: validate
                                ? AppLocale.enterReason.getString(context)
                                : null,
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.w,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: kBlue,
                                width: 3.w,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  RoundedButton(
                    label: AppLocale.submit.getString(context),
                    labelColor: Colors.white,
                    buttonColor: kBlack,
                    onPressed: () {
                      if (selectedReason['id'] == 0 &&
                          tfController.text.trim().isEmpty) {
                        setState(() => validate = true);
                      } else {
                        tfController.dispose();
                        Navigator.of(context).pop({
                          'reasonId': selectedReason['id'] as int,
                          'text': tfController.text.trim(),
                        });
                      }
                    },
                  ),
                ],
                actionsAlignment: MainAxisAlignment.center,
              );
            },
          );
        },
      ),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
