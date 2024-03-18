import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:tayar_app/src/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/data/repos/auth_repo_impl.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepoImpl repoImpl;
  late AuthRemoteDataSource remoteDataSource;
  late AuthLocalDataSource localDataSource;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    localDataSource = MockAuthLocalDataSource();
    repoImpl = AuthRepoImpl(remoteDataSource, localDataSource);
  });

  const tUser = UserModel.empty();
  const tException = ServerException(message: 'Not found', statusCode: 500);
  const tCacheEx = CacheException(message: 'not found', statusCode: 500);

  group('Sign In', () {
    const tTelephoneNo = 'test.teleNo';
    const tPass = 'test.pass';
    const tOrgId = 'test.OrgId';

    test(
      'should call [RemoteDataSource.SignIn] '
      'and retun [UserModel] when successfull',
      () async {
        //arrange
        when(
          () => remoteDataSource.signIn(
            telephoneNo: any(named: 'telephoneNo'),
            password: any(named: 'password'),
            orgId: any(named: 'orgId'),
          ),
        ).thenAnswer((_) async => tUser);

        // act
        final result = await repoImpl.signIn(
          orgId: tOrgId,
          telephoneNo: tTelephoneNo,
          password: tPass,
        );

        // assert
        expect(result, isA<Right<dynamic, UserEntity>>());
        verify(
          () => remoteDataSource.signIn(
            telephoneNo: tTelephoneNo,
            password: tPass,
            orgId: tOrgId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'Should return [ServerFailure] when call to '
      '[AuthRemoteDataSource.signIn] is unsuccessfull',
      () async {
        //arrange
        when(
          () => remoteDataSource.signIn(
            telephoneNo: any(named: 'telephoneNo'),
            password: any(named: 'password'),
            orgId: any(named: 'orgId'),
          ),
        ).thenThrow(tException);

        //act
        final result = await repoImpl.signIn(
          orgId: tOrgId,
          telephoneNo: tTelephoneNo,
          password: tPass,
        );

        //assert
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.signIn(
            telephoneNo: tTelephoneNo,
            password: tPass,
            orgId: tOrgId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('forget Password', () {
    const tTelephoneNo = 'test.TeleNo';
    test(
      'Should call [AuthRemoteDataSource.forgetPassword] '
      ' and complete successfully when the call is successfull',
      () async {
        //arrange
        when(
          () => remoteDataSource.forgotPassword(
            telephoneNo: any(named: 'telephoneNo'),
          ),
        ).thenAnswer((_) async => Future.value());

        //act
        final result = await repoImpl.forgetPassword(telephoneNo: tTelephoneNo);

        //assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.forgotPassword(
            telephoneNo: tTelephoneNo,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'Should return [ServerFailure] when call to '
      ' [AuthRemoteDataSource.forgetPassword] is unsuccessfull',
      () async {
        //arrange
        when(
          () => remoteDataSource.forgotPassword(
            telephoneNo: any(named: 'telephoneNo'),
          ),
        ).thenThrow(tException);

        //act
        final result = await repoImpl.forgetPassword(telephoneNo: tTelephoneNo);

        //assert
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.forgotPassword(telephoneNo: tTelephoneNo),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('create Password', () {
    const tPass = 'test Pass';
    const tdriverId = 0;
    const tOrgId = 'test OrgId';
    test(
      'Should call [AuthRemoteDataSource.forgetPassword] and complete '
      'successfully when the call is successfull',
      () async {
        when(
          () => remoteDataSource.createPassword(
            password: any(named: 'password'),
            driverId: any(named: 'driverId'),
            orgId: any(named: 'orgId'),
          ),
        ).thenAnswer((_) async => Future.value());

        //act
        final result = await repoImpl.createPassword(
          password: tPass,
          driverId: tdriverId,
          orgId: tOrgId,
        );

        //assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.createPassword(
            password: tPass,
            driverId: tdriverId,
            orgId: tOrgId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
        'Should return [ServerFailure] when call to '
        ' [AuthRemoteDataSource.CreatePassword] is unsuccessfull', () async {
      //arrange
      when(
        () => remoteDataSource.createPassword(
          password: any(named: 'password'),
          driverId: any(named: 'driverId'),
          orgId: any(named: 'orgId'),
        ),
      ).thenThrow(tException);

      //act
      final result = await repoImpl.createPassword(
        password: tPass,
        driverId: tdriverId,
        orgId: tOrgId,
      );

      //assert
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );
      verify(
        () => remoteDataSource.createPassword(
          password: tPass,
          driverId: tdriverId,
          orgId: tOrgId,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

 

  group('logout', () {
    test(
        'Should call [AuthlocalDatasource.logout] and complete '
        'successfully when the call is successfull', () async {
      when(
        () => localDataSource.logout(),
      ).thenAnswer((_) async => Future.value());

      final result = await repoImpl.logout();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => localDataSource.logout(),
      ).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'Should return [CacheFailure] when call to '
        ' [AuthLocalDataSource.logout] is unsuccessfull', () async {
      when(
        () => localDataSource.logout(),
      ).thenThrow(tCacheEx);

      final result = await repoImpl.logout();

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(
              message: tCacheEx.message,
              statusCode: tCacheEx.statusCode,
            ),
          ),
        ),
      );

      verify(
        () => localDataSource.logout(),
      ).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('save user', () {
    test(
        'Should call [AuthlocalDatasource.saveUser] and complete '
        'successfully when the call is successfull', () async {
      when(
        () => localDataSource.saveUser(user: tUser),
      ).thenAnswer((_) async => Future.value());

      final result = await repoImpl.saveUser(user: tUser);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => localDataSource.saveUser(user: tUser),
      ).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'Should return [CacheFailure] when the call '
        ' [AuthlocalDatasource.saveUSer] is successfull', () async {
      when(
        () => localDataSource.saveUser(user: tUser),
      ).thenThrow(tCacheEx);

      final result = await repoImpl.saveUser(user: tUser);

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(
              message: tCacheEx.message,
              statusCode: tCacheEx.statusCode,
            ),
          ),
        ),
      );

      verify(
        () => localDataSource.saveUser(user: tUser),
      ).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

 
}
