import 'package:flutter/material.dart';
import 'login_page.dart'; 
import 'register_page.dart'; 

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool showLoginPage = true;

 
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    if (showLoginPage) {
      currentPage = LoginPage(onTap: togglePages);
    } else {
      currentPage = RegisterPage(onTap: togglePages);
    }
    return Scaffold(
      body: currentPage,
    );
  }
}
