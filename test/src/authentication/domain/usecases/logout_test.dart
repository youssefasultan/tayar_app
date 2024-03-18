import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/authentication/domain/usecases/logout.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late Logout usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = Logout(repo);
  });

  test('should call [Logout]', () async {
    when(
      () => repo.logout(),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase();

    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repo.logout(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
