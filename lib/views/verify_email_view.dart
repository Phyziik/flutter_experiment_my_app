import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify email"),),
      body: Column(
        children: [
          Text('Please verify your email address'),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            },
            child: const Text("Verify"),
          )
        ],
      ),
    );
  }
}
