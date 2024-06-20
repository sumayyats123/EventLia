import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorRegisterScreenWrapper extends StatelessWidget {
  const VendorRegisterScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const VendorRegisterScreen(),
    );
  }
}

class VendorRegisterScreen extends StatelessWidget {
  const VendorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}