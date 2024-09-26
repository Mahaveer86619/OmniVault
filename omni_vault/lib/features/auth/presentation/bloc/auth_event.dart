part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class SendPassResetOtpEvent extends AuthEvent {
  final String email;

  SendPassResetOtpEvent({
    required this.email,
  });
}

class VerifyOtpEvent extends AuthEvent {
  final String code;
  final String email;

  VerifyOtpEvent({
    required this.code,
    required this.email,
  });
}

class ResetPassEvent extends AuthEvent {
  final String email;
  final String password;

  ResetPassEvent({
    required this.email,
    required this.password,
  });
}
