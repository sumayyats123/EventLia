

// import 'package:equatable/equatable.dart';
// import 'package:eventlia/layers/domain/models/admin_model.dart';

// abstract class AuthAdminEvent extends Equatable {
//   const AuthAdminEvent();

//   @override
//   List<Object> get props => [];
// }

// class CheckLoginStatusEvent extends AuthAdminEvent {}

// class SignupEvent extends AuthAdminEvent {
//   final AdminModel admin;

//   const SignupEvent(this.admin);

//   @override
//   List<Object> get props => [admin];
// }

// class LoginEvent extends AuthAdminEvent {
//   final String email;
//   final String password;

//   const LoginEvent({required this.email, required this.password});

//   @override
//   List<Object> get props => [email, password];
// }

// class LogoutEvent extends AuthAdminEvent {}