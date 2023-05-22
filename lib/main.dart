import 'package:book_exchange_admin/screens/login_or_register_page.dart';
import 'package:book_exchange_admin/screens/nav_page.dart';
import 'package:book_exchange_admin/screens/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Exchange_Admin',
      theme: ThemeData.dark().copyWith(),
      routes: {
        '/login_or_register': (context) => const LoginOrRegisterPage(),
        '/Profile_page': (context) => const ProfilePage(),
        '/Navigation_page': (context) => const NavigationPage(),
      },
    );
  }
}
