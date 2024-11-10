import 'package:flutter/material.dart';

class CardBackground extends StatelessWidget {
  const CardBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      color: const Color.fromRGBO(175, 23, 64, 1),
      child: const Icon(Icons.delete,
          color: Color.fromARGB(255, 255, 255, 255), size: 40),
    );
  }
}
