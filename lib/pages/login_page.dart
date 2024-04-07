import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_mcd/components/new_textfield.dart'; 
import 'package:app_mcd/pages/register_page.dart'; 

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUserIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
  
      return;
    }

  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text("Signing in..."),
          ],
        ),
      ),
    );
  },
);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pop(); 
      
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); 
      showErrorMessage(e.message ?? 'An error occurred. Please try again.');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Icon(Icons.people, size: 100, color: Color.fromARGB(255, 35, 32, 30)),
                  const SizedBox(height: 30),
                  const Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 20),
                  NewTextField(controller: emailController, hintText: 'Email', obscureText: false),
                  const SizedBox(height: 20),
                  NewTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => signUserIn(context),
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      'Don\'t have an account? Register here',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
