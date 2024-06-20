part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User? user;

  Authenticated(this.user);
}

class UnAuthenticated extends AuthState {}

class AuthenticatedError extends AuthState {
  final String message;

  AuthenticatedError({required this.message});
}

// Forgot password states
class ForgotPasswordInitial extends AuthState {}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ForgotPasswordFailure extends AuthState {
  final String message;

  ForgotPasswordFailure({required this.message});
}

// Reset password states
class ResetPasswordInitial extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordFailure extends AuthState {
  final String message;

  ResetPasswordFailure({required this.message});
}
