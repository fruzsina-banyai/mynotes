import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_tutorial/services/auth/auth_exceptions.dart';
import 'package:second_tutorial/services/auth/bloc/auth_bloc.dart';
import 'package:second_tutorial/services/auth/bloc/auth_event.dart';
import 'package:second_tutorial/services/auth/bloc/auth_state.dart';
import 'package:second_tutorial/services/extensions/buildcontext/loc.dart';
import 'package:second_tutorial/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFountAuthException ||
              state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
                context, "Cannot find a user with the entered credentials!");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Authentication error!");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.login_title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Please log in to your account to be able to interact with your notes!",
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    const InputDecoration(hintText: "Your email here..."),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration:
                    const InputDecoration(hintText: "Your password here..."),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogIn(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventForgotPassword(),
                      );
                },
                child: const Text("I forgot my password"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventShouldRegister(),
                      );
                },
                child: const Text("Not registered yet? Register here!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
