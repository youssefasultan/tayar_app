import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/repos/auth_repo.dart';

class SaveUser extends UsecaseWithParams<void, UserEntity> {
  SaveUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UserEntity params) => _repo.saveUser(user: params);
}
