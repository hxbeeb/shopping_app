import 'package:fashion/screens/home/screen1.dart';
import 'package:fashion/screens/home/screen2.dart';
import 'package:fashion/screens/home/screen3.dart';
import 'package:fashion/screens/home/screen4.dart';
import 'package:fashion/screens/home/screen5.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
    var i = 0;
  List screens = [const screen1(), const screen2(), const screen3(), const screen4(), const screen5()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[i],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (v) {
              setState(() {
                i = v;
              });
            },
            type: BottomNavigationBarType.fixed,
            items:  [
              BottomNavigationBarItem(
                  icon:Icon(Icons.person,color: i==0?Colors.purple:Colors.grey,) ,
                  label: ""),
              BottomNavigationBarItem(
                  icon:Icon(Icons.group,color: i==1?Colors.purple:Colors.grey,),
                  label: ""),
              BottomNavigationBarItem(
                  icon:Icon(Icons.home,color: i==2?Colors.purple:Colors.grey,),
                  label: ""),
              BottomNavigationBarItem(
                  icon:Icon(CupertinoIcons.heart_circle,color: i==3?Colors.purple:Colors.grey,),
                  label: ""),
              BottomNavigationBarItem(
                  icon:Icon(CupertinoIcons.chat_bubble,color: i==4?Colors.purple:Colors.grey,) ,
                  label: "")
            ]),
      );
  }
}