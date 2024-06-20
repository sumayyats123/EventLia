import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomwScreenWrapper extends StatelessWidget {
  const HomwScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // Navigate to login screen when unauthenticated
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 3, 60),
          actions: [
            IconButton(
              onPressed: () {
                final authBloc = BlocProvider.of<AuthBloc>(context);
                authBloc.add(LogOutEvent());
              },
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
        body: const Center(
          child: Text("Home page"),
        ),
      ),
    );
  }
}
