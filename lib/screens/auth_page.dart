
import 'package:book_exchange_admin/screens/login_or_register_page.dart';
import 'package:book_exchange_admin/screens/nav_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // final user = FirebaseAuth.instance.currentUser;
            // return user!.emailVerified ? UserPage() : const VerifyEmailPage();
            return NavigationPage();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
