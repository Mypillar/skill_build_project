import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:skill_build_project/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const Formpage(),
    );
  }
}

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;

  Future<void> signupUser() async {
    final String url = 'https://swiftkartexpress.com/api/signup.php';

    if (fullname.text.isEmpty ||
        email.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    if (password.text != confirmPassword.text) {
      showMessage("Passwords do not match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'fullname': fullname.text.trim(),
          'email': email.text.trim(),
          'phone': phoneNumber.text.trim(),
          'password': password.text,
          'confirmPassword': confirmPassword.text,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showMessage(data['message']);
        // Navigate to login after successful signup
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser()));
      } else {
        showMessage(data['message']);
      }
    } catch (e) {
      showMessage("An error occurred: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton.icon(
                    onPressed: () {},
                    label: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                    )),
                TextButton.icon(
                    onPressed: signupUser,
                    icon: const Icon(Icons.save, color: Colors.teal),
                    label: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)))
              ]),
              const SizedBox(height: 30.0),
              TextField(
                controller: fullname,
                decoration: const InputDecoration(
                    icon: Icon(BootstrapIcons.person, color: Colors.teal),
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    icon: Icon(BootstrapIcons.envelope, color: Colors.teal),
                    labelText: 'Email',
                    hintText: 'Johndoe@gmail.com',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    icon: Icon(BootstrapIcons.phone, color: Colors.teal),
                    labelText: 'Phone Number',
                    hintText: '+23490965345',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(BootstrapIcons.file_lock, color: Colors.teal),
                    labelText: 'Password',
                    hintText: '******',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: confirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(BootstrapIcons.unlock, color: Colors.teal),
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: isLoading ? null : signupUser,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('OR'),
              const SizedBox(height: 10.0),
              const Text('Sign Up Via'),
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.google, color: Colors.teal),
                    label: const Text('Google')),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.twitter_x, color: Colors.teal),
                    label: const Text('Twitter')),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.facebook, color: Colors.teal),
                    label: const Text('Facebook')),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.apple, color: Colors.teal),
                    label: const Text('Apple')),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
