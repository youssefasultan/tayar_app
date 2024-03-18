import 'package:tayar_app/core/usecases/usecase.dart';
import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/repos/auth_repo.dart';

class Logout extends UsecaseWithoutParams<void> {
  Logout(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call() => _repo.logout();
}
