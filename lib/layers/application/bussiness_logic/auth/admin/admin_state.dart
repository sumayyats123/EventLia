// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// abstract class AuthAdminState extends Equatable {
//   const AuthAdminState();

//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthAdminState {}

// class AuthLoading extends AuthAdminState {}

// class Authenticated extends AuthAdminState {
//   final User user;

//   const Authenticated(this.user);

//   @override
//   List<Object> get props => [user];
// }

// class UnAuthenticated extends AuthAdminState {}

// class AuthenticatedError extends AuthAdminState {
//   final String message;

//   const AuthenticatedError({required this.message});

//   @override
//   List<Object> get props => [message];
// }