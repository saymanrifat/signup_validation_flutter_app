import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_bloc.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_event.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SizedBox(height: 10),
            BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
              if (state is SignInErrorState) {
                return Text(
                  state.errorMessage,
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            }),
            TextField(
              controller: emailController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              },
              decoration: InputDecoration(hintText: "Email Address"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Password"),
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInLoadState) {
                  return Center(child: CircularProgressIndicator());
                }
                return CupertinoButton(
                  child: Text("Sign in"),
                  onPressed: () {
                    if (state is SignInValidState) {
                      BlocProvider.of<SignInBloc>(context).add(
                        SignInSubmittedEvent(
                            emailController.text, passwordController.text),
                      );
                    }
                  },
                  color:
                      (state is SignInValidState) ? Colors.blue : Colors.grey,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
