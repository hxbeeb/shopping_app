import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class item extends StatelessWidget {
  const item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const Image(
                      image: NetworkImage(
                          "https://4.imimg.com/data4/DM/RM/MY-16551252/mens-blazer-500x500.jpg"),
                      width: 100,
                      height: 100,
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              
                            },
                            icon: const Icon(
                              CupertinoIcons.heart,
                              color: Colors.red,
                            )))
                  ],
                ),
                const Text("name"),
                const Text("username"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(width: double.infinity,height: 250,
                                  child: item()),
                              );
                            });
                      },
                      child: const Text("more"),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: Text("link"),
                ),
                Text("brand"),
                Text("colors"),
                Text("category")
              ],
            )
          ],
        ),
      ),
    );
  }
}
