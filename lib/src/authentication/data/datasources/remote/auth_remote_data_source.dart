import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:tayar_app/core/common/response/login_response.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword({required String telephoneNo});

  Future<UserModel> signIn({
    required String telephoneNo,
    required String password,
    required String orgId,
  });

  Future<void> createPassword({
    required String password,
    required int driverId,
    required String orgId,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  final localization = FlutterLocalization.instance;

  @override
  Future<UserModel> signIn({
    required String telephoneNo,
    required String password,
    required String orgId,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(
          kBaseUrl,
          kSignInEndPoint,
        ),
        headers: kHeader,
        body: jsonEncode({
          'PhoneNumber': telephoneNo,
          'Password': password,
          'Org_ID': orgId,
        }),
      );

      final responseData =
          LogInResponse.fromJson(json.decode(response.body) as DataMap);

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      if (responseData.users == null) {
        throw ServerException(
          message: responseData.message!,
          statusCode: int.parse(responseData.rCode!),
        );
      }

      return responseData.users![0];
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> forgotPassword({required String telephoneNo}) {
    // TODO(youssef): implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<void> createPassword({
    required String password,
    required int driverId,
    required String orgId,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(kBaseUrl, kCreatePassEndPoint),
        headers: kHeader,
        body: jsonEncode({
          'driverId': driverId,
          'Password': password,
          'Org_ID': orgId,
        }),
      );

      if (response.statusCode != 200) {
        final responseData = json.decode(response.body) as DataMap;
        throw ServerException(
          message: localization.currentLocale?.languageCode == 'en'
              ? responseData['enMessage'] as String
              : responseData['arMessage'] as String,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
