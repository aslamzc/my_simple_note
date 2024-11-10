import 'package:flutter/material.dart';

class CardBackground2 extends StatelessWidget {
  const CardBackground2({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: const Color.fromRGBO(49, 81, 30, 1),
      child: const Icon(Icons.archive,
          color: Color.fromARGB(255, 255, 255, 255), size: 40),
    );
  }
}
