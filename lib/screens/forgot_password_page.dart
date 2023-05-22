
import 'package:book_exchange_admin/components/my_button.dart';
import 'package:book_exchange_admin/components/my_textfield.dart';
import 'package:book_exchange_admin/components/show_error_message.dart';
import 'package:book_exchange_admin/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _email = TextEditingController();
  void showSuccessDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('reset password successful'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            content: const Text(
                'A link to reset your password has been sent to you email'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage(
                          onTap: () {},
                        );
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      Navigator.pop(context);
      showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.code.toString(), e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Enter your email and we will send you a password reset link',
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          MyTextField(
            controller: _email,
            hintText: 'Email',
            keyboard: TextInputType.emailAddress,
            obscureText: false,
          ),
          const SizedBox(
            height: 25.0,
          ),
          MyButton(
            onPressed: passwordReset,
            text: 'Reset Password',
          ),
        ],
      ),
    );
  }
}
