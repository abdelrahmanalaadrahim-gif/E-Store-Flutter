
import 'package:flutter/material.dart';
import '../login_page.dart';

class AccountPage extends StatelessWidget {
  final Map<String, String> user;
  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account"),
      backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text("Email: ${user['email']}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            // Text("Password: ${user['password']}", style: const TextStyle(fontSize: 20)),
            // const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // تسجيل الخروج: يرجع لصفحة Login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
