import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          TextButton(
            child: Text("Register"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: email, password: password);
                print(userCredential);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/login/", (route) => false);
              } on FirebaseAuthException catch (e) {
                if(e.code == "weak-password" || e.code == "email-already-in-use" || e.code == "invalid-email") {
                  print(e.message);
                }
                else{
                  print("Unhandled code ${e.code}");
                }
              }
            },
          ),
          TextButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil("/login/", (route) => false);
          }, child: const Text("Already registered? Login here!"))
        ],
      ),
    );
  }
}

