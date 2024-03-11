import 'package:flutter/material.dart';
import 'package:policypro/constants/routes.dart';
import 'package:policypro/enums/menu_action.dart';
import 'package:policypro/services/auth/auth_service.dart';

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
        title: const Text("User Dashboard"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if(shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                )
              ];
            }
          ),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding:EdgeInsets.only(top:40, left:20, right:20,),
        child: Text("Welcome to PolicyPro!",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'open_sans',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out"),
        content : const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, 
            child: const Text("Logout")
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, 
            child: const Text("Cancel"),
          ),
        ],
      );
    }
  ).then((value) => value ?? false);
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
            buildHeader(context),
            buildMenuitems(context),
      ],
      ),
    ),
  );
  
Widget buildHeader(BuildContext context) => Container(
  color: Color.fromARGB(255, 62, 162, 255),
  padding: EdgeInsets.only(
    top:MediaQuery.of(context).padding.top,
  ),
);

Widget buildMenuitems(BuildContext context) => Container(
  padding: const EdgeInsets.all(24),
  child: Wrap(
    runSpacing: 30,
    children: [
      ListTile(
        leading: const Icon(Icons.workspaces_outline),
        title: const Text("Chat", 
          style: TextStyle(fontSize: 20,),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.help_outline),
        title: const Text("Help", 
          style: TextStyle(fontSize: 20,),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.feedback_outlined),
        title: const Text("Feedback", 
          style: TextStyle(fontSize: 20,),
        ),
        onTap: () {},
      ),
    ],
  ),
);
}