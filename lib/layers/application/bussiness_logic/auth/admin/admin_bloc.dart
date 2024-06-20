// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventlia/layers/application/bussiness_logic/auth/admin/admin_event.dart';
// import 'package:eventlia/layers/application/bussiness_logic/auth/admin/admin_state.dart';

// class AuthAdminBloc extends Bloc<AuthAdminEvent, AuthAdminState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   AuthAdminBloc() : super(AuthInitial()) {
//     on<CheckLoginStatusEvent>((event, emit) async {
//       User? user;
//       try {
//         await Future.delayed(Duration(seconds: 2), () {
//           user = _auth.currentUser;
//         });

//         if (user != null) {
//           emit(Authenticated(user!));
//         } else {
//           emit(UnAuthenticated());
//         }
//       } catch (error) {
//         emit(AuthenticatedError(message: error.toString()));
//       }
//     });

//     on<SignupEvent>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final userCredential = await _auth.createUserWithEmailAndPassword(
//           email: event.admin.email!,
//           password: event.admin.password!,
//         );
//         final user = userCredential.user;

//         if (user != null) {
//           await FirebaseFirestore.instance.collection('admins').doc(user.uid).set({
//             'uid': user.uid,
//             'email': user.email,
//             'name': event.admin.name,
//             'phone': event.admin.phonenumber,
//             'createdAt': FieldValue.serverTimestamp(),
//           });
//           emit(Authenticated(user));
//         } else {
//           emit(UnAuthenticated());
//         }
//       } catch (error) {
//         emit(AuthenticatedError(message: error.toString()));
//       }
//     });

//     on<LoginEvent>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final userCredential = await _auth.signInWithEmailAndPassword(
//           email: event.email,
//           password: event.password,
//         );
//         final user = userCredential.user;

//         if (user != null) {
//           emit(Authenticated(user));
//         } else {
//           emit(UnAuthenticated());
//         }
//       } catch (error) {
//         emit(AuthenticatedError(message: error.toString()));
//       }
//     });

//     on<LogoutEvent>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         await _auth.signOut();
//         emit(UnAuthenticated());
//       } catch (error) {
//         emit(AuthenticatedError(message: error.toString()));
//       }
//     });
//   }
// }