import 'package:eventlia/layers/application/presentaion/screens/admin/login_screen.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/forgotpassword_screen.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/home_screen.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/signup_screen.dart';
import 'package:eventlia/layers/application/presentaion/screens/vendor/login_screen.dart';
import 'package:eventlia/layers/domain/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:eventlia/layers/application/presentaion/widgets/textformfield.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          emailController.clear();
          passwordController.clear();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomwScreenWrapper()),
            (route) => false,
          );
        } else if (state is AuthenticatedError) {
          if (state.message.contains('invalid-email') ||
              state.message.contains('user-not-found')) {
            _showSnackbar(context, 'Invalid email or password');
          } else if (state.message.contains('wrong-password')) {
            _showSnackbar(context, 'Wrong password');
          } else {
            _showSnackbar(context, state.message);
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
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
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    obscureText: true,
                    controller: passwordController,
                    hintText: 'Enter Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authBloc.add(
                          LoginEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      } else {
                        _showSnackbar(context, 'Please correct the errors in the form');
                      }
                    },
                    child: const Text('Login'),
                  ),
                  ksizedbox20,
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ForgotPasswordScreen (),));

                    },
                    child: const Text("Forgot Password?",style: TextStyle(fontSize: 12, color: Colors.blue),),
                  ),
                  ksizedbox20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminLoginScreenWrapper(),
                          ));
                        },
                        child: const Text(
                          'Are you an admin? Click here to login',
                          style: TextStyle(
                            fontSize: 12 ,
                            color: Colors.blue,
                          ),
                        ), 
                      ),
                     const SizedBox(height: 10,), 
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VendorLoginScreenWrapper(),
                          ));
                        },
                        child: const Text(
                          'Are you a vendor? Click here to Register',
                          style: TextStyle(
                            fontSize: 12   ,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ksizedbox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New here? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 ,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPgeWrapper (),
                          ));
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
