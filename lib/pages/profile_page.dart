
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Text("Name: John Doe", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Email: johndoe@example.com", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Phone: +20 123 456 789", style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            Text(
              "هنا يمكن لاحقًا تعديل البيانات أو تسجيل الخروج",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
