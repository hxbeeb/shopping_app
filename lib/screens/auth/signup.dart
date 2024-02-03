// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/screens/auth/signin.dart';
import 'package:fashion/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var done = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  final aut = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text(
              controller: name,
              hint: "Name",
              i: const Icon(Icons.person),
              obs: false),
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
                if (pass.text.length > 6 && name.text != "") {
                  try {
                    await aut.createUserWithEmailAndPassword(
                        email: email.text, password: pass.text);
                    setState(() {
                      done = true;
                    });
                    await aut.currentUser!.updatePhotoURL(
                        "https://media.istockphoto.com/id/1332100919/vector/man-icon-black-icon-person-symbol.jpg?s=612x612&w=0&k=20&c=AVVJkvxQQCuBhawHrUhDRTCeNQ3Jgt0K1tXjJsFy1eg=");
                    await aut.currentUser!.updateDisplayName(name.text);

                    await db
                        .collection("users")
                        .doc(email.text.toString())
                        .set({
                      "name": name.text,
                      "id": email.text,
                      "pass": pass.text,
                      "uid": aut.currentUser!.uid,
                      "dp":
                          "https://media.istockphoto.com/id/1332100919/vector/man-icon-black-icon-person-symbol.jpg?s=612x612&w=0&k=20&c=AVVJkvxQQCuBhawHrUhDRTCeNQ3Jgt0K1tXjJsFy1eg="
                    });
                    setState(() {
                      done = false;
                    });
                    Navigator.pushReplacementNamed(context, '/home');
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Text("user already exist!"),
                          );
                        });
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text(
                              "Enter you name, valid email and Password must be of more than 6 characters"),
                        );
                      });
                }
              },
              child: done == false
                  ? const Text("Sign Up")
                  : const CircularProgressIndicator()),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const signin()));
              },
              child: const Text("Sign In")),
        ],
      ),
    );
  }
}
