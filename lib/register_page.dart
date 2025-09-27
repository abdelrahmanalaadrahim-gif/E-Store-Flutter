
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final List<Map<String, String>> users;
  const RegisterPage({super.key, required this.users});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();

  void register() {
    String email = emailController.text.trim();
    String password = passwordController.text;
                                      ////////////لو موجود قبل كده
    bool emailExists =
        widget.users.any((user) => user['email'] == email);


    if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email already registered")),
      );
    } else {

      if (email.isEmpty || password.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text("Email and password cannot be empty")),
                 );
            return;
                    }

      widget.users.add({"email": email, "password": password});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),
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
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
