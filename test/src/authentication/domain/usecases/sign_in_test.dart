import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/usecases/sign_in.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignIn usecase;

  const tTelephoneNo = 'test telephoneNo';
  const tPassword = 'test password';
  const tOrgId = 'test orgId';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });

  const tUser = UserEntity.empty();

  test('Should return [UserEntity] from [AuthRepo]', () async {
    // arrange
    when(
      () => repo.signIn(
        telephoneNo: any(named: 'telephoneNo'),
        password: any(named: 'password'),
        orgId: any(named: 'orgId'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    // act

    final result = await usecase(
      const SignInParams(
        telephoneNo: tTelephoneNo,
        password: tPassword,
        orgId: tOrgId,
      ),
    );

    // assert

    expect(result, const Right<dynamic, UserEntity>(tUser));
      verify(
        () => repo.signIn(
          telephoneNo: tTelephoneNo,
          password: tPassword,
          orgId: tOrgId,
        ),
      ).called(1);

      verifyNoMoreInteractions(repo);
  });
}
