part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.telephoneNo,
    required this.password,
    required this.orgId,
  });

  final String telephoneNo;
  final String password;
  final String orgId;

  @override
  List<Object?> get props => [telephoneNo, password];
}

class ForgetPasswordEvent extends AuthEvent {
  const ForgetPasswordEvent({
    required this.telephoneNo,
  });

  final String telephoneNo;

  @override
  List<Object?> get props => [telephoneNo];
}

class CreatePasswordEvent extends AuthEvent {
  const CreatePasswordEvent({
    required this.user,
    required this.newPassword,
  });

  final UserModel user;
  final String newPassword;

  @override
  List<Object?> get props => [user, newPassword];
}

class LogoutRequestedEvent extends AuthEvent {}
