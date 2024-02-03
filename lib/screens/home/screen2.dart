import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/providers/msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class screen2 extends StatefulWidget {
  const screen2({super.key});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    search.addListener(() {
      onsearch();
    });
    // TODO: implement initState
    super.initState();
  }

  onsearch() {
    searchresult();
    print(search.text);
  }

  List all = [];
  List result = [];
  get() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .get();
    setState(() {
      all = data.docs;
    });
    searchresult();
  }

  searchresult() {
    var showresult = [];
    if (search.text != "") {
      for (var client in all) {
        var name = client["name"].toString().toLowerCase();
        if (name.contains(search.text.toLowerCase())) {
          showresult.add(client);
        }
      }
    } else {
      showresult = List.from(all);
    }
    setState(() {
      result = showresult;
    });
  }

  @override
  void didChangeDependencies() {
    get();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    search.removeListener(() {
      onsearch();
      search.dispose();
    });
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aut = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    final fetch = db.collection("users");
    var search_name = "";
    return Consumer<message>(builder: (BuildContext context, v, Widget? child) {
      return SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: search,
                onChanged: (value) {
                  setState(() {
                    search_name = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 39, 39, 39),
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
              ),
              const Card(child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                  CircleAvatar(child: Text("+"),),
                  SizedBox(width: 20,),
                  Text("Create a group")
                ],),
              ),),
              Text("Existing Groups"),
              Expanded(
                  child: StreamBuilder(
                      stream: db.collection("users").doc(aut.currentUser!.uid)
                          .collection("groups")
                          // .orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    v.other = snapshot.data!.docs[index]["id"];
                                    v.dp = snapshot.data!.docs[index]["dp"];
                                    v.name = snapshot.data!.docs[index]["name"];
                                 
          
                                    Navigator.pushNamed(context, '/chat');
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.docs[index]["dp"]),
                                            radius: 25,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot
                                                    .data!.docs[index]["name"]
                                                    .toString()),
                                                // Icon(snapshot.data!.docs[index]
                                                //             ["read"] !=
                                                //         true
                                                //     ? Icons.notifications
                                                //     : null)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return const Center(child: CircularProgressIndicator());
                      }))
            ],
          ),
        ),
      ));
    });
  }
}
