import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skill_build_project/login.dart';
import 'package:skill_build_project/signup.dart';
import 'package:skill_build_project/homepage.dart' as homepage;
import 'package:skill_build_project/mycourse.dart' as mycourse;
import 'package:skill_build_project/support.dart';
import 'package:skill_build_project/myprofile.dart'; // You'll create this next

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        } else {
          bool isLoggedIn = snapshot.data ?? false;
          return MyApp(initialRoute: isLoggedIn ? '/home' : '/login');
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginUser(),
        '/signup': (context) => const Formpage(),
        '/home': (context) => const homepage.MainHomePage(),
        '/mycourses': (context) => const mycourse.MyCourse(),
        '/support': (context) => const Support(),
        '/myprofile': (context) => const MyProfile(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
