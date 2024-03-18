import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/usecases/save_user.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SaveUser usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = SaveUser(repo);
  });

  const tUser = UserEntity.empty();

  test('should call [SaveUser]', () async {
    when(
      () => repo.saveUser(user: tUser),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(tUser);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
        () => repo.saveUser(user: tUser),
      ).called(1);
      verifyNoMoreInteractions(repo);
  });
}
