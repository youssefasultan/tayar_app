import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<UserEntity> signIn({
    required String orgId,
    required String telephoneNo,
    required String password,
  });

  ResultFuture<void> forgetPassword({required String telephoneNo});

  ResultFuture<void> createPassword({
    required String password,
    required int driverId,
    required String orgId,
  });

  ResultFuture<void> saveUser({required UserEntity user});
  
  ResultFuture<void> logout();
}
