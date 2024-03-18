import 'package:dartz/dartz.dart';
import 'package:tayar_app/core/errors/exceptions.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:tayar_app/src/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource, this._authLocalDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  ResultFuture<void> forgetPassword({required String telephoneNo}) async {
    try {
      await _remoteDataSource.forgotPassword(telephoneNo: telephoneNo);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultFuture<UserEntity> signIn({
    required String orgId,
    required String telephoneNo,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        telephoneNo: telephoneNo,
        password: password,
        orgId: orgId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultFuture<void> createPassword({
    required String password,
    required int driverId,
    required String orgId,
  }) async {
    try {
      await _remoteDataSource.createPassword(
        password: password,
        driverId: driverId,
        orgId: orgId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }


  @override
  ResultFuture<void> logout() async {
    try {
      await _authLocalDataSource.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> saveUser({required UserEntity user}) async {
    try {
      await _authLocalDataSource.saveUser(user: user as UserModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

}
