import 'dart:developer';

import '../../../../core/util/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import 'signup_page.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import '../../../blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial && state.authstate == Authstate.failure) {
              log("  the state when exe log in page${state.authstate}");
              showSnackBar(context, state.m ?? "asdfgafdgaddffg");
            } else if (state is AuthInitial &&
                state.authstate == Authstate.succes) {
              log("  the state when exe log in page${state.authstate}");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BlogPage.route()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthInitial && state.authstate == Authstate.loading) {
              log("the state when exe log in page${state.authstate}");
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("log in"),
                  const SizedBox(height: 30),
                  AuthField(hintText: 'Email', controller: emailcontroller),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordcontroller,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign in',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: emailcontroller.text.trim(),
                                password: passwordcontroller.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
