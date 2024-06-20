
import 'package:eventlia/layers/application/bussiness_logic/auth/user/auth_bloc.dart';
import 'package:eventlia/layers/application/presentaion/screens/user/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()
        ),
      ],
      child: MaterialApp(
        home: const SplashWrapper(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData( scaffoldBackgroundColor: const Color.fromARGB(255, 6, 3, 60),
         
        ),
      ),
    );
  }
}
