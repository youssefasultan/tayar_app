import 'package:equatable/equatable.dart';
import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/repos/auth_repo.dart';

class CreatePassword extends UsecaseWithParams<void, CreatePasswordParams> {
  const CreatePassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(CreatePasswordParams params) => _repo.createPassword(
        password: params.password,
        driverId: params.driverId,
        orgId: params.orgId,
      );
}

class CreatePasswordParams extends Equatable {
  const CreatePasswordParams({
    required this.password,
    required this.driverId,
    required this.orgId,
  });

  const CreatePasswordParams.empty()
      : password = '',
        driverId = 0,
        orgId = '';

  final String password;
  final int driverId;
  final String orgId;
  @override
  List<Object?> get props => [password, driverId];
}
