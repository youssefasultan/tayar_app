import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/repos/auth_repo.dart';

class SignIn extends UsecaseWithParams<UserEntity, SignInParams> {
  const SignIn(this._repo);

  final AuthRepo _repo;
  @override
  ResultFuture<UserEntity> call(SignInParams params) => _repo.signIn(
        telephoneNo: params.telephoneNo,
        password: params.password,
        orgId: params.orgId,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.telephoneNo,
    required this.password,
    required this.orgId,
  });

  const SignInParams.empty()
      : telephoneNo = '',
        password = '',
        orgId = '';

  final String telephoneNo;
  final String password;
  final String orgId;

  @override
  List<Object?> get props => [telephoneNo, password];

}
