// import 'package:eventlia/layers/application/presentaion/screens/user/Resetpassword_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();

//   ForgotPasswordScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//       ),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is ForgotPasswordSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Password reset email sent')),
//             );
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ResetPasswordScreen(), // Replace with your reset password screen
//               ),
//             );
//           } else if (state is ForgotPasswordFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   final email = emailController.text.trim();
//                   if (email.isNotEmpty) {
//                     BlocProvider.of<AuthBloc>(context).add(ForgotPasswordEvent(email: email));
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please enter your email')),
//                     );
//                   }
//                 },
//                 child: const Text('Send Reset Email'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:eventlia/layers/application/presentaion/widgets/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Password reset link sent! Check your email"),
          );
        },
      );

      // Clear the email field after showing the dialog
      emailController.clear();

      // Close the dialog after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 3, 60),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Enter your email", style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFormField(
              controller: emailController,
              hintText: 'Enter Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.white,
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );
  }
}
