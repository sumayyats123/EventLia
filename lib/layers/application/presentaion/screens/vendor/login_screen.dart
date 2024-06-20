import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorLoginScreenWrapper extends StatelessWidget {
  const VendorLoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const VendorLoginScreen(),
    );
  }
}

class VendorLoginScreen extends StatelessWidget {
  const VendorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}