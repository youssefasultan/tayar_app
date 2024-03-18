import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/utils/core_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CallService {
  CallService(this.context);

  late BuildContext context;

  void makePhoneCall(String phoneNumber) {
    canLaunchUrl(Uri(scheme: 'tel', path: '333')).then((bool result) async {
      if (result) {
        final launchUri = Uri(
          scheme: 'tel',
          path: phoneNumber,
        );
        await launchUrl(launchUri);
      } else {
        CoreUtils.showSnackBar(
          context,
          AppLocale.cannotCall.getString(context),
        );
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
