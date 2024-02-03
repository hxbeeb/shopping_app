import 'package:fashion/widgets/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class screen3 extends StatefulWidget {
  const screen3({super.key});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var value=0;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Discover',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                // leading: const Icon(Icons.home),
                title: const Text('Suggested'),
                onTap: () {
                  // Add your navigation logic here
                },
              ),
              ListTile(
                // leading: const Icon(Icons.settings),
                title: const Text('Followers'),
                onTap: () {
                  // Add your navigation logic here
                },
              ),
              ListTile(
                // leading: const Icon(Icons.settings),
                title: const Text('Following'),
                onTap: () {
                  // Add your navigation logic here
                },
              ),
            ],
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                onChanged: (v) {
                  value = v!;
                },
                value: value,
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text("--NONE--"),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text("Category"),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text("Colors"),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text("Season"),
                  )
                ]),
            item()
          ],
        ),
      ),
    );
  }
}

