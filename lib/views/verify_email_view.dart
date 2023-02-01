import 'package:flutter/material.dart';
import 'package:second_tutorial/constants/routes.dart';
import 'package:second_tutorial/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text(
              "We have sent you a verification email. Please verify your email address through the link you have recieved!"),
          const Text(
              "If you haven't recieved the email, please tap the button below for trying again."),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send verification email"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if (!mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
