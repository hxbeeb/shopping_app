import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/providers/msg.dart';
import 'package:fashion/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final db = FirebaseFirestore.instance;
  final aut = FirebaseAuth.instance;

  final TextEditingController msg = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<message>(
        builder: (BuildContext context, message v, Widget? child) {
     

      final add = db
          .collection("users")
          .doc(aut.currentUser!.uid.toString())
          .collection("groups")
          .doc(v.other.toString())
          .collection("chats");
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Row(children: [
              CircleAvatar(
                backgroundImage: NetworkImage(v.dp ?? ""),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(v.name ?? "")
            ]),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: add
                        // .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var docs = snapshot.data!.docs[index];
                              return SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    if (docs["sender"] ==
                                        aut.currentUser!.email)
                                      Card(
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        100, 5, 0, 5),
                                                child: Card(
                                                    color: Colors.grey,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              docs['msg'] ?? "",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          20)),
                                                          Text(
                                                              "${docs["hour"]}:${docs["minute"]}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10))
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      Card(
                                        elevation: 0,
                                        child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(v.dp),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 5, 100, 5),
                                                      child: Card(
                                                          color: Colors.grey,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    docs['msg'] ??
                                                                        "",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            20)),
                                                                Text(
                                                                    "${docs["hour"]}:${docs["minute"]}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                    ))
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ))),
                                      )
                                  ],
                                ),
                              );
                            });
                      }
                      return const Center(child: Text("Send a Message"));
                    }),
              ),
              text(
                  s: IconButton(
                      onPressed: () async {
                        var txt = msg.text;
                        var time = DateTime.now().millisecondsSinceEpoch;
                        msg.clear();
               
                        await db
                            .collection("users")
                            .doc(aut.currentUser!.uid.toString())
                            .collection("groups")
                            .doc(v.other.toString())
                            .collection("chats")
                            .doc(time.toString())
                            .set({
                          "msg": txt,
                          "sender": aut.currentUser!.email,
                          "year": DateTime.now().year.toString(),
                          "month": DateTime.now().month.toString(),
                          "date": DateTime.now().day.toString(),
                          "hour": DateTime.now().hour.toString(),
                          "minute": DateTime.now().minute.toString(),
                          "second": DateTime.now().second.toString(),
                          "timestamp": Timestamp.now().millisecondsSinceEpoch
                        });
                       
                      },
                      icon: const Icon(Icons.send)),
                  controller: msg,
                  hint: "Type ur message",
                  obs: false),
            ],
          ));
    });
  }
}
