import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_service.dart';
// import 'dart:developer' show log;

class VarifyEmailView extends StatefulWidget {
  const VarifyEmailView({super.key});

  @override
  State<VarifyEmailView> createState() => _VarifyEmailViewState();
}

class _VarifyEmailViewState extends State<VarifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Varify email"),
      ),
      body: Column(
        children: [
          const Text("We already sent you an email verification. Please verify your email address"),
          const Text("If you haven't received a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
              AuthService.firebase().sendEmailVerification();
            },
            child : const Text("Send email verification"),
          ),
          TextButton(onPressed: () async{
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
           child:  const Text("Restart"))
        ],),
    );
  }
}
