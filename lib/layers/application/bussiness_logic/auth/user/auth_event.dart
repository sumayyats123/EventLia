part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckLoginStatusEvent extends AuthEvent {}

// Login event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

// Signup event
class SignupEvent extends AuthEvent {
  final UserModel user;

  SignupEvent({required this.user});
}

class LogOutEvent extends AuthEvent {}

// Forgot password event
class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

// Reset password event
class ResetPasswordEvent extends AuthEvent {
  final String newPassword;
  final String confirmPassword;
  final String oobCode;  // Out of band code from email link

  ResetPasswordEvent({
    required this.newPassword,
    required this.confirmPassword,
    required this.oobCode,
  });
}
