import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/home_screen.dart';
import 'package:eventlia/layers/application/presentaion/widgets/textformfield.dart';
import 'package:eventlia/layers/domain/core/constant.dart';
import 'package:eventlia/layers/domain/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPgeWrapper extends StatelessWidget {
  const RegisterPgeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        // Clear text fields after successful registration
        emailController.clear();
        passwordController.clear();
        nameController.clear();
        phoneController.clear();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomwScreenWrapper()
          ));
        });
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 3, 60),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ksizedbox20,
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
                        ksizedbox20,
                        CustomTextFormField(
                          obscureText: true,
                          controller: passwordController,
                          hintText: 'Enter Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        ksizedbox20,
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Enter Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        ksizedbox20,
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: 'Enter Phone Number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        ksizedbox20,
                        InkResponse(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phonenumber: phoneController.text,
                              );
                              authBloc.add(SignupEvent(user: user));
                            } else {
                              _showSnackbar(context, 'Please correct the errors in the form');
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 233, 202, 109),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an Account?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomwScreenWrapper(),
                                ));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
