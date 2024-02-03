// ignore_for_file: use_build_context_synchronously

import 'package:fashion/screens/auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Closet"),
        actions: [
          TextButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => signin()));
              },
              child: Text("Log Out"))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(auth.currentUser!.photoURL.toString()),
                      ),
                      Text(auth.currentUser!.displayName.toString())
                    ],
                  ),
                  const Column(
                    children: [
                      Text("My Closet"),
                      Row(
                        children: [
                          CircleAvatar(child: Icon(Icons.add)),
                          Text("Add New")
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("tops"),
                        Image(
                          image: AssetImage("assets/download.jpeg"),
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Bottoms"),
                        Image(
                          image: AssetImage("assets/images.jpeg"),
                          height: 200,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Sweatpants"),
                        Image(
                          image: AssetImage("assets/sweatpants.jpg"),
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Jeans"),
                        Image(
                          image: AssetImage("assets/jeans.jpg"),
                          fit: BoxFit.fill,
                          height: 200,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Shoes"),
                        Image(
                          image: AssetImage("assets/shoes.jpg"),
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Jewellery"),
                        Image(
                          image: AssetImage("assets/jewellery.jpg"),
                          fit: BoxFit.fill,
                          height: 200,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
