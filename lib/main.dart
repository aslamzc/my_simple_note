import 'package:flutter/material.dart';
import 'package:my_simple_note/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coursework 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark
        ),
      home: const HomeScreen(),
    );
  }
}
