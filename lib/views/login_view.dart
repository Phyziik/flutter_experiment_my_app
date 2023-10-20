import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  submitLogin() async {
    if(_formKey.currentState!.validate()) {
      final email = _email.text;
      final password = _password.text;

      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/notes/", (route) => false);
        devtools.log(userCredential.toString());
      } on FirebaseAuthException catch (e) {
        if (e.code == "INVALID_LOGIN_CREDENTIALS") {
          print("Wrong credentials");
        } else {
          print("Unhandled code ${e.code}");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),),
      body: Form(
        key:_formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _email,
              onFieldSubmitted: (value) async {
                await submitLogin();
              },
              decoration: const InputDecoration(
                hintText: 'Enter your email here',
              ),
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _password,
              onFieldSubmitted: (value) async {
                await submitLogin();
              },
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextButton(
              child: Text("Login"),
              onPressed: () async {
                await submitLogin();
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil("/register/", (route) => false);
                },
                child: const Text("Not registered yet? Register here!"))
          ],
        ),
      ),
    );
  }
}
