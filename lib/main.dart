import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:second_tutorial/constants/routes.dart';
import 'package:second_tutorial/views/login_view.dart';
import 'package:second_tutorial/views/notes/create_update_note_view.dart';
import 'package:second_tutorial/views/notes/notes_view.dart';
import 'package:second_tutorial/views/register_view.dart';
import 'package:second_tutorial/views/verify_email_view.dart';
import 'package:second_tutorial/services/auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const NotesView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
