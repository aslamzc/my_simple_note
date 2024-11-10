import 'package:flutter/material.dart';
import 'package:my_simple_note/screens/Home.dart';
import 'package:my_simple_note/screens/archive.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({super.key});
  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const ListTile(
          title: Text(
            'Simple Note',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Dark Theme'),
          value: Theme.of(context).brightness == Brightness.dark,
          activeColor: const Color.fromRGBO(166, 174, 191, 1),
          onChanged: (value) {
            setState(() {
              final theme = value ? ThemeData.dark() : ThemeData.light();
              runApp(
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  home: const HomeScreen(),
                ),
              );
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.archive),
          title: const Text('Archive'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ArchiveScreen(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
