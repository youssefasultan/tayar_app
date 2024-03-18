import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/domain/usecases/create_password.dart';
import 'package:tayar_app/src/authentication/domain/usecases/sign_in.dart';

import '../../../../../fixture/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSourceImpl remoteDataSource;
  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  const tException = ServerException(message: 'Not found', statusCode: 500);
  final tResponse = jsonDecode(fixture('user_response.json')) as DataMap;
  const tUser = UserModel.empty();

  group('SignIn', () {
    const tSignInParams = SignInParams.empty();
    test('Should return a [User Model] when status is 200', () async {
      //arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(tResponse),
          200,
        ),
      );

      // act
      final methodCall = await remoteDataSource.signIn(
        orgId: tSignInParams.orgId,
        telephoneNo: tSignInParams.telephoneNo,
        password: tSignInParams.password,
      );

      //assert
      expect(
        methodCall,
        equals(tUser),
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kSignInEndPoint,
          ),
          headers: kHeader,
          body: jsonEncode({
            'PhoneNumber': tSignInParams.telephoneNo,
            'Password': tSignInParams.password,
            'Org_ID': tSignInParams.orgId,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [ServerException] when status code is not 200 or 201',
      () async {
        // arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenThrow(tException);
        // act
        final methodCall = remoteDataSource.signIn;

        // assert
        expect(
          () async => methodCall(
            orgId: 'orgId',
            telephoneNo: 'telephoneNo',
            password: 'password',
          ),
          throwsA(
            ServerException(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.http(
              kBaseUrl,
              kSignInEndPoint,
            ),
            headers: kHeader,
            body: jsonEncode(
              {
                'PhoneNumber': 'telephoneNo',
                'Password': 'password',
                'Org_ID': 'orgId',
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Create Password', () {
    const tCreatePassParams = CreatePasswordParams.empty();

    test('Should return a successfull when status is 200', () async {
      //arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Password has been updated successfully',
          200,
        ),
      );

      // act
      final methodCall = remoteDataSource.createPassword;

      //assert
      expect(
        methodCall(
          password: tCreatePassParams.password,
          driverId: tCreatePassParams.driverId,
          orgId: tCreatePassParams.orgId,
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kCreatePassEndPoint,
          ),
          headers: kHeader,
          body: jsonEncode({
            'driverId': tCreatePassParams.driverId,
            'Password': tCreatePassParams.password,
            'Org_ID': tCreatePassParams.orgId,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should return [ServerException] when status is not 200', () async {
      //arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(tException);

      // act
      final methodCall = remoteDataSource.createPassword(
        password: tCreatePassParams.password,
        driverId: tCreatePassParams.driverId,
        orgId: tCreatePassParams.orgId,
      );

      //assert
      expect(
        methodCall,
        throwsA(
          ServerException(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.http(
            kBaseUrl,
            kCreatePassEndPoint,
          ),
          headers: kHeader,
          body: jsonEncode({
            'driverId': tCreatePassParams.driverId,
            'Password': tCreatePassParams.password,
            'Org_ID': tCreatePassParams.orgId,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  // TODO(youssef): write test for forgetPaswword
}
