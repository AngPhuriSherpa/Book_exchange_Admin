import 'dart:async';
import 'package:book_exchange_admin/components/my_alt_button.dart';
import 'package:book_exchange_admin/components/my_button.dart';
import 'package:book_exchange_admin/components/show_error_message.dart';
import 'package:book_exchange_admin/screens/nav_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;

  Timer? timer;
  @override
  void initState() {
    super.initState();
    checkEmailVerified();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await Future.delayed(const Duration(seconds: 5));
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => isEmailVerified = false);
      return;
    }
    await user.reload();
    setState(() => isEmailVerified = user.emailVerified);
    if (!isEmailVerified) {
      await user.sendEmailVerification();
      timer = Timer.periodic(
          const Duration(seconds: 5), (_) => checkEmailVerified());
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      await Future.delayed(const Duration(seconds: 5));
    } on FirebaseAuthException catch (e) {
      showErrorMessage(context, e.code.toString(), e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? NavigationPage()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A verification email has been sent to your email',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                onPressed: sendVerificationEmail,
                text: 'Send Verification Email',
              ),
              const SizedBox(
                height: 25,
              ),
              MyAltButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                text: 'Cancel',
              ),
            ],
          ));
}
