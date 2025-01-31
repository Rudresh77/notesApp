import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/enums/menu_action.dart';
import 'package:notes_app/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value)
            {

              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if(shouldLogout)
                {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
            }
          },
          itemBuilder: (context) {
            return  const[
              PopupMenuItem(value : MenuAction.logout, child: Text('log out'),)
            ];
          },
          )
        ],
      ),
      body: const Text("Hello world"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context)
{
  return showDialog<bool>(context: context, builder: (context)
  {
    return AlertDialog(
      title: const Text('Sign out'),
      content: const Text('Are you sur you want to sign out?'),
      actions: [
        TextButton(onPressed: 
        (){
          Navigator.of(context).pop(false);
        }, child: const Text('Cancel')),
        TextButton(onPressed: 
        (){
          Navigator.of(context).pop(true);
        }, child: const Text('Log out')),
      ],
    );
  }
  ).then((value) => value ?? false);
}