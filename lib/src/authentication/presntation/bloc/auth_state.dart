part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

class SignedInWithoutInit extends AuthState {
  const SignedInWithoutInit(this.user);

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class SignedInWithInit extends AuthState {
  const SignedInWithInit(this.user);

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class CreatePasswordSent extends AuthState {
  const CreatePasswordSent();
}

class LoggedOut extends AuthState {
  const LoggedOut();
}
