import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_bloc.dart';
import 'package:signup_validation/screens/sign_in/sign_up.dart';
import 'package:signup_validation/screens/welcome/welcome_page.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomePages(),
      ),
    );
  }
}
