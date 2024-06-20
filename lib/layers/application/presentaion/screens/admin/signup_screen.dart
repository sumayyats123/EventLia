import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRegisterScreenWrapper extends StatelessWidget {
  const AdminRegisterScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AdminRegisterScreen(),
    );
  }
}

class AdminRegisterScreen extends StatelessWidget {
  const AdminRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
