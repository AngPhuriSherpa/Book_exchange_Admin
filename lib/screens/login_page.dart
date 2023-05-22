
import 'package:book_exchange_admin/components/my_button.dart';
import 'package:book_exchange_admin/components/my_textfield.dart';
import 'package:book_exchange_admin/components/show_error_message.dart';
import 'package:book_exchange_admin/components/tile.dart';
import 'package:book_exchange_admin/screens/forgot_password_page.dart';
import 'package:book_exchange_admin/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      showErrorMessage(context, e.code.toString(), e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo.PNG',
                  height: 100,
                ),
                SizedBox(height: 25),
                Text(
                  'Welcome to Book Exchange App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _email,
                  hintText: 'Email',
                  keyboard: TextInputType.emailAddress,
                  obscureText: false,
                ),
                SizedBox(height: 20),
                MyTextField(
                  controller: _password,
                  hintText: 'Password',
                  obscureText: true,
                  keyboard: TextInputType.text,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                MyButton(
                  onPressed: signUserIn,
                  text: 'Sign in',
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or continue with'),
                    ),
                    Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black))
                  ],
                ),
                SizedBox(height: 25),
                Tile(
                  imagePath: 'assets/images/signin.jpg',
                  imageText: 'Sign in with Google',
                  onTap: () {
                    AuthService().signInWithGoogle();
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a useruser?'),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
