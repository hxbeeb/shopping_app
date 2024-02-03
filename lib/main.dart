// ignore_for_file: must_be_immutable

import 'package:fashion/firebase_options.dart';
import 'package:fashion/providers/msg.dart';
import 'package:fashion/screens/auth/signup.dart';
import 'package:fashion/screens/chat.dart';
import 'package:fashion/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  var auth=FirebaseAuth.instance;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => message())],
      child:  MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:auth.currentUser!=null?homepage(): signup(),routes: {
          "/home":(context) => homepage(),
          "/chat":(context) => chat()
        },));
  }
}
