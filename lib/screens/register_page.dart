import 'package:book_exchange_admin/components/my_button.dart';
import 'package:book_exchange_admin/components/my_textfield.dart';
import 'package:book_exchange_admin/components/show_error_message.dart';
import 'package:book_exchange_admin/components/tile.dart';
import 'package:book_exchange_admin/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firestore = FirebaseFirestore.instance.collection('users');
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _userName = TextEditingController();
  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future signUserUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      String uid =
          userCredential.user!.uid; // Get the UID of the newly created user
      addUserDetails(uid, _userName.text, _email.text);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(context, e.code.toString(), e.message.toString());
    }
  }

  Future addUserDetails(String uid, String userName, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid) // Use the UID as the document ID
        .set({'userName': userName, 'email': email, 'gender': '-'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Image.asset(
                  'assets/images/logo.PNG',
                  height: 125,
                ),
                const Text('Create an account'),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  controller: _userName,
                  hintText: 'Full Name',
                  obscureText: false,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MyTextField(
                  controller: _email,
                  hintText: 'Email',
                  keyboard: TextInputType.emailAddress,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MyTextField(
                  controller: _password,
                  hintText: 'Password',
                  obscureText: true,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                MyButton(
                  onPressed: signUserUp,
                  text: 'Sign Up',
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or continue with'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Tile(
                  imagePath: 'assets/images/signin.png',
                  imageText: 'Sign in with Google',
                  onTap: () {
                    AuthService().signInWithGoogle();
                  },
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
