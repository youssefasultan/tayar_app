import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tayar_app/core/errors/failure.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/domain/usecases/create_password.dart';
import 'package:tayar_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:tayar_app/src/authentication/domain/usecases/logout.dart';
import 'package:tayar_app/src/authentication/domain/usecases/save_user.dart';
import 'package:tayar_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockForgetPassword extends Mock implements ForgotPassword {}

class MockCreatePassword extends Mock implements CreatePassword {}

class MockLogout extends Mock implements Logout {}

class MockSaveUSer extends Mock implements SaveUser {}

void main() {
  late SignIn signIn;
  late ForgotPassword forgotPassword;
  late CreatePassword createPassword;
  late Logout logout;
  late SaveUser saveUser;
  late AuthBloc authBloc;

  const tSignInParams = SignInParams.empty();
  const tCreatePasswordParams = CreatePasswordParams.empty();
  const tServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'there is no user recored',
  );
  const tUser = UserModel.empty();

  setUp(() {
    signIn = MockSignIn();
    forgotPassword = MockForgetPassword();
    createPassword = MockCreatePassword();
    logout = MockLogout();
    saveUser = MockSaveUSer();

    authBloc = AuthBloc(
      signIn: signIn,
      forgotPassword: forgotPassword,
      createPassword: createPassword,
      logout: logout,
      saveUser: saveUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tCreatePasswordParams);
    registerFallbackValue(tUser);
  });

  tearDown(() => authBloc.close());

  test('initialState should be [AuthInitial]', () {
    expect(authBloc.state, const AuthInitial());
  });

  group('SignIn Event', () {
    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, SignedInWithInit] when '
      '[SignIn] event is added',
      build: () {
        when(
          () => signIn(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          telephoneNo: tSignInParams.telephoneNo,
          password: tSignInParams.password,
          orgId: tSignInParams.orgId,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedInWithInit(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(tSignInParams),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, SignedInWithoutInit] when '
      '[SignIn] event is added',
      build: () {
        when(
          () => signIn(any()),
        ).thenAnswer((_) async => Right(tUser.copyWith(isInitial: false)));

        when(
          () => saveUser(any()),
        ).thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          telephoneNo: tSignInParams.telephoneNo,
          password: tSignInParams.password,
          orgId: tSignInParams.orgId,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedInWithoutInit(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(tSignInParams),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, AuthError] when signIn fails',
      build: () {
        when(
          () => signIn(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          telephoneNo: tSignInParams.telephoneNo,
          password: tSignInParams.password,
          orgId: tSignInParams.orgId,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signIn(tSignInParams),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('Create Password', () {
    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, CreatePasswordSent] when '
      'CreatePasswordEvent is Added and PasswordCreated successfully',
      build: () {
        when(
          () => createPassword(any()),
        ).thenAnswer((_) async => const Right(null));

        when(
          () => saveUser(any()),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        CreatePasswordEvent(
          user: tUser,
          newPassword: tCreatePasswordParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const CreatePasswordSent(),
      ],
      verify: (_) {
        verify(
          () => createPassword(tCreatePasswordParams),
        ).called(1);
        verifyNoMoreInteractions(createPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, AuthError] when '
      'CreatePasswordEvent is unsuccessfully',
      build: () {
        when(
          () => createPassword(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        CreatePasswordEvent(
          user: tUser,
          newPassword: tCreatePasswordParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => createPassword(tCreatePasswordParams),
        ).called(1);
        verifyNoMoreInteractions(createPassword);
      },
    );
  });

  group('forget password', () {
    const tTeleoneNo = 'test.TelephoneNo';
    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, forgetPasswordSent] when '
      'forgetPasswordEvent is Added and sent successfully',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordEvent(
          telephoneNo: tTeleoneNo,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(tTeleoneNo),
        ).called(1);
        verifyNoMoreInteractions(createPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Should emit [AuthLoading, AuthError] when '
      'forgetPasswordEvent is unsuccessfully',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordEvent(
          telephoneNo: tTeleoneNo,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(tTeleoneNo),
        ).called(1);
        verifyNoMoreInteractions(createPassword);
      },
    );
  });
}
