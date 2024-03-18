import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';

List<DataMap>? cancelReasons;

class Helpers {
  Helpers();

  Future<void> initHelpers(BuildContext context) async {
    await getCancelReasons(context);
  }

  final localization = FlutterLocalization.instance;

  Future<void> getCancelReasons(BuildContext context) async {
    final response = await http.get(
      Uri.http(
        kBaseUrl,
        kGetCancelReasonsEndPoint,
      ),
      headers: kHeader,
    );

    final responseData = json.decode(response.body) as List<dynamic>;

    cancelReasons = responseData
        .map(
          (e) => {
            'id': (e as DataMap)['id'],
            'reason': localization.currentLocale!.languageCode == 'en'
                ? e['reason_En']
                : e['reason_Ar'],
          },
        )
        .toList();

    cancelReasons!.add({
      'id': 0,
      'reason':
          localization.currentLocale!.languageCode == 'en' ? 'Other' : 'أخري',
    });
  }
}
