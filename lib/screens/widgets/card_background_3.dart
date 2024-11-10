import 'package:flutter/material.dart';

class CardBackground3 extends StatelessWidget {
  const CardBackground3({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: const Color.fromARGB(255, 96, 158, 60),
      child: const Icon(Icons.unarchive,
          color: Color.fromARGB(255, 255, 255, 255), size: 40),
    );
  }
}
