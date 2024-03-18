import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/src/authentication/domain/usecases/forgot_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late ForgotPassword usecase;

  const tTelephoneNo = 'test mail';

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPassword(repo);
  });

  test('Should call [ForgotPassword]', () async {
    // arrange
    when(
      () => repo.forgetPassword(telephoneNo: any(named: 'telephoneNo')),
    ).thenAnswer((_) async => const Right(null));

    // act

    final result = await usecase(tTelephoneNo);

    // assert

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.forgetPassword(telephoneNo: tTelephoneNo),
    ).called(1);

    verifyNoMoreInteractions(repo);
  });
}
