import 'package:flutter/material.dart';
import 'package:store_app/pages/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final List<Map<String, String>> users = [];

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    bool userExists = users.any(
      (user) => user['email'] == email && user['password'] == password,
    );
    //////////check
    if (userExists) {
      final Map<String, String> currentUser = {
        "email": email,
        "password": password,
      };

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(currentUser: currentUser)),
      );
    }
    ///if incorrect
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true, /////يشفر الباسورد
              decoration: const InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage(users: users)),
                );
              },
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
