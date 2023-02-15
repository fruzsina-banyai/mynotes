import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_tutorial/constants/routes.dart';
import 'package:second_tutorial/services/auth/bloc/auth_bloc.dart';
import 'package:second_tutorial/services/auth/bloc/auth_event.dart';
import 'package:second_tutorial/services/auth/bloc/auth_state.dart';
import 'package:second_tutorial/services/auth/firebase_auth_provider.dart';
import 'package:second_tutorial/views/login_view.dart';
import 'package:second_tutorial/views/notes/create_update_note_view.dart';
import 'package:second_tutorial/views/notes/notes_view.dart';
import 'package:second_tutorial/views/register_view.dart';
import 'package:second_tutorial/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
