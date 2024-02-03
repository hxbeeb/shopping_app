import 'package:fashion/screens/auth/signup.dart';
import 'package:fashion/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  var done = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final aut = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text(
            controller: email,
            hint: 'Email',
            i: const Icon(Icons.email),
            obs: false,
          ),
          text(
            controller: pass,
            hint: 'Password',
            i: const Icon(Icons.password),
            obs: true,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  done = true;
                });
                try {
                  await aut.signInWithEmailAndPassword(
                      email: email.text, password: pass.text);
                      Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Incorrect email or password"),
                        );
                      });
                }

                
                setState(() {
                  done = false;
                });
              },
              child: done == false
                  ? const Text("Sign In")
                  : const CircularProgressIndicator()),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => signup()));
              },
              child: const Text("Sign Up")),
        ],
      ),
    );
  }
}
