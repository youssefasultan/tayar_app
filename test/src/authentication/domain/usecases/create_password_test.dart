import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/authentication/domain/usecases/create_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late CreatePassword usecase;

  const tPassword = 'test password';
  const tDriverId = 0;
  const tOrgId = 'test OrgId';

  setUp(() {
    repo = MockAuthRepo();
    usecase = CreatePassword(repo);
  });

  test(
    'Should call [CreatePassword]',
    () async {
      // arrange
      when(
        () => repo.createPassword(
          password: any(named: 'password'),
          driverId: any(named: 'driverId'),
          orgId: any(named: 'orgId'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // act

      final result = await usecase(
        const CreatePasswordParams(
          driverId: tDriverId,
          password: tPassword,
          orgId: tOrgId,
        ),
      );

      //assert

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repo.createPassword(
          password: tPassword,
          driverId: tDriverId,
          orgId: tOrgId,
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
