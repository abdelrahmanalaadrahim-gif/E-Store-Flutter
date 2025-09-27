

import 'package:flutter/material.dart';
import 'package:store_app/login_page.dart';
import 'package:store_app/pages/account_page.dart';


class SettingsPage extends StatelessWidget {
  final Map<String, String> currentUser;
  const SettingsPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings ⚙️"),
      ),
      body: ListView(
        children: [
          Card(
              color: const Color.fromARGB(255, 210, 231, 236),
          child:ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account"),
            subtitle: Text("Email: ${currentUser['email']}"),
           onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AccountPage( user: currentUser),
               ),
             );
              }

          ),),
          Card(
              color: const Color.fromARGB(255, 210, 231, 236),
          child:ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            subtitle: const Text("Made by Mohamed Atia & Abdelrahman Alaa"),
             onTap: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("About Us"),
          content: const Text("Made by Mohamed Atia & Abdelrahman Alaa"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      );
    },
          ),),
          Card(
              color: const Color.fromARGB(255, 210, 231, 236),
          child:ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) =>  LoginPage()),
      (route) => false,
    );
            },
          ),)
        ],
      ),
    );
  }
}
