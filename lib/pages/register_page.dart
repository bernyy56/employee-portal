import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_mcd/components/new_textfield.dart'; 
import 'package:app_mcd/pages/login_page.dart'; 

class RegisterPage extends StatefulWidget {
  final VoidCallback? onTap;

  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUserUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    if (passwordController.text != confirmPasswordController.text) {
      showErrorMessage('Passwords do not match.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text("Registering..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pop(); 
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); 
      showErrorMessage('Failed to sign up: ${e.message}');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registration Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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
                  const SizedBox(height: 60),
                  const Icon(Icons.person_add, size: 100, color: Color.fromARGB(255, 35, 32, 30)),
                  const SizedBox(height: 30),
                  const Text('Register', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 20),
                  NewTextField(controller: emailController, hintText: 'Email', obscureText: false),
                  const SizedBox(height: 20),
                  NewTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 20),
                  NewTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => signUserUp(context),
                    child: const Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.yellow,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context), 
                    child: const Text(
                      'Already have an account? Login here',
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



