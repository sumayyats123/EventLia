import 'package:eventlia/layers/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      try {
        await Future.delayed(const Duration(seconds: 2), () {
          user = _auth.currentUser;
        });

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (error) {
        emit(AuthenticatedError(message: error.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user.email,
          password: event.user.password,
        );
        final user = userCredential.user;

        if (user != null) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': user.email,
            'name': event.user.name,
            'phone': event.user.phonenumber,
            'createdAt': DateTime.now(),
          });
          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (error) {
        emit(AuthenticatedError(message:error.toString()));
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        await _auth.signOut();
        emit(UnAuthenticated());
      } catch (error) {
        emit(AuthenticatedError(message: error.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user;
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      }on FirebaseAuthException catch(error){
        print("NOT WORKING, ${error.message}");
      }
       catch (error) {
        emit(AuthenticatedError(message: error.toString()));
       
      }
    });

    // Handle forgot password event
    on<ForgotPasswordEvent>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        await _auth.sendPasswordResetEmail(email: event.email);
        emit(ForgotPasswordSuccess());
      } catch (error) {
        emit(ForgotPasswordFailure(message: error.toString()));
      }
    });

    // Handle reset password event
    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        if (event.newPassword != event.confirmPassword) {
          emit(ResetPasswordFailure(message: "Passwords do not match"));
          return;
        }
        await _auth.confirmPasswordReset(
          code: event.oobCode,
          newPassword: event.newPassword,
        );
        emit(ResetPasswordSuccess());
      } catch (error) {
        emit(ResetPasswordFailure(message: error.toString()));
      }
    });
  }
}
