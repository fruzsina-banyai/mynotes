import 'package:flutter/material.dart';
import 'package:second_tutorial/constants/routes.dart';
import 'package:second_tutorial/services/auth/auth_exceptions.dart';
import 'package:second_tutorial/services/auth/auth_service.dart';
import 'package:second_tutorial/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: "Enter your e-mail here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: "Enter your password here"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                if (!mounted) return;
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                showErrorDialog(
                  context,
                  "Weak password. Password must be atleast 6 characters long and contain at least one number and one letter!",
                );
              } on EmailAlreadyInUseAuthException {
                showErrorDialog(
                  context,
                  "Email address is already in use.",
                );
              } on InvalidEmailAuthException {
                showErrorDialog(
                  context,
                  "Invalid email address. Email must contain @ and . at the correct places!",
                );
              } on GenericAuthException {
                showErrorDialog(
                  context,
                  "Failed to register",
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Already registered? Login here!"),
          )
        ],
      ),
    );
  }
}
