import 'package:flutter/material.dart';

class text extends StatelessWidget {
  const text({super.key, required this.controller, required this.hint, this.i, required this.obs, this.s});

  final TextEditingController controller;
  final String hint;
  final Icon? i;
  final bool obs;
  final IconButton? s;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        TextField(
          obscureText: obs,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(hint),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: i,
              suffixIcon: s),
        ),
      ]),
    );
  }
}