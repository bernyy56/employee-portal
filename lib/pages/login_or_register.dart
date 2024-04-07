import 'package:flutter/material.dart';
import 'login_page.dart'; // Make sure this is the correct path to your LoginPage widget
import 'register_page.dart'; // Make sure this is the correct path to your RegisterPage widget

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Choose the current page based on showLoginPage
    Widget currentPage;
    if (showLoginPage) {
      currentPage = LoginPage(onTap: togglePages);
    } else {
      currentPage = RegisterPage(onTap: togglePages);
    }

    // Return the current page wrapped in a Scaffold
    return Scaffold(
      body: currentPage,
    );
  }
}
