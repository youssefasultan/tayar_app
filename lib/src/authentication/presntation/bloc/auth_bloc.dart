import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';
import 'package:tayar_app/src/authentication/domain/usecases/create_password.dart';
import 'package:tayar_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:tayar_app/src/authentication/domain/usecases/logout.dart';
import 'package:tayar_app/src/authentication/domain/usecases/save_user.dart';
import 'package:tayar_app/src/authentication/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required ForgotPassword forgotPassword,
    required CreatePassword createPassword,
    required Logout logout,
    required SaveUser saveUser,
  })  : _signIn = signIn,
        _forgotPassword = forgotPassword,
        _createPassword = createPassword,
        _logout = logout,
        _saveUser = saveUser,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });

    on<SignInEvent>(_signInHandler);
    on<CreatePasswordEvent>(_createPasswordHandler);
    on<ForgetPasswordEvent>(_forgetPasswordHandler);
    on<LogoutRequestedEvent>(_logoutHandler);
  }
  final SignIn _signIn;
  final ForgotPassword _forgotPassword;
  final CreatePassword _createPassword;
  final Logout _logout;
  final SaveUser _saveUser;

  Future<void> _logoutHandler(
    LogoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _logout();

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (r) => emit(const LoggedOut()),
    );
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _signIn(
      SignInParams(
        telephoneNo: event.telephoneNo,
        password: event.password,
        orgId: event.orgId,
      ),
    ).then(
      (value) => value.fold(
        (failure) => emit(AuthError(message: failure.errorMessage)),
        (user) async {
          if (user.isInitial) {
            
            emit(SignedInWithInit(user));
          } else {
            await _saveUser(user)
              .whenComplete(() => emit(SignedInWithoutInit(user)));
           
          }
        },
      ),
    );
  }

  Future<void> _createPasswordHandler(
    CreatePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _createPassword(
      CreatePasswordParams(
        password: event.newPassword,
        driverId: event.user.driverId,
        orgId: event.user.orgId.toString(),
      ),
    ).then(
      (value) => value.fold(
        (failure) => emit(AuthError(message: failure.errorMessage)),
        (r) async {
          await _saveUser(event.user)
              .whenComplete(() => emit(const CreatePasswordSent()));
        },
      ),
    );
  }

  Future<void> _forgetPasswordHandler(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.telephoneNo);

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }
}
