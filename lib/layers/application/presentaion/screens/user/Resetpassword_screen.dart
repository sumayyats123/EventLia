// import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Reset Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: newPasswordController,
//                 decoration: const InputDecoration(labelText: 'Enter new password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a new password';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: confirmPasswordController,
//                 decoration: const InputDecoration(labelText: 'Confirm new password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your new password';
//                   }
//                   if (value != newPasswordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final newPassword = newPasswordController.text.trim();
//                     final confirmPassword = confirmPasswordController.text.trim();
//                     BlocProvider.of<AuthBloc>(context).add(
//                       ResetPasswordEvent(
//                         newPassword: newPassword,
//                         confirmPassword: confirmPassword,
//                         oobCode: 'oobCode', // Replace with actual out of band code
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text('Reset Password'),
//               ),
//               BlocListener<AuthBloc, AuthState>(
//                 listener: (context, state) {
//                   if (state is ResetPasswordSuccess) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Password reset successful')),
//                     );
//                     Navigator.of(context).pop();
//                   } else if (state is ResetPasswordFailure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.message)),
//                     );
//                   }
//                 },
//                 child: Container(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }