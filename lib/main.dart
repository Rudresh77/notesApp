import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/views/notes_view.dart';
import 'package:notes_app/views/register_view.dart';
import 'package:notes_app/views/verify_email_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      // home: const RegisterView(),
      home:  const HomePage(),
      routes: {
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute : (context) => const NotesView(),
        verifyEmailRoute : (context) => const VarifyEmailView(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

   @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initializ(),
        builder:(context, snapshot) 
        {
          switch (snapshot.connectionState){
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if(user != null)
              {
                if(user.isEmailVerified)
                {
                  return const NotesView();
                }
                else{
                  // return const LoginView();
                  return const VarifyEmailView();
                }
              }
              else{
                return const LoginView();
              }
            default:
              return const LinearProgressIndicator();
          }
          
        },
      );
  }
}




