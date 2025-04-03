import 'package:employ_form/Screans/homescreen.dart';
import 'package:employ_form/login_and_sign_up/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wraper extends StatefulWidget {
  const Wraper({super.key});

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Homescreen();
          } else {
            return loginscreen(); // Added 'return' here
          }
        },
      ),
    );
  }
}
