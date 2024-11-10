import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';
import 'package:my_simple_note/screens/create_note.dart';
import 'package:my_simple_note/screens/widgets/note_add_button.dart';
import 'package:my_simple_note/screens/widgets/note_card.dart';
import 'package:my_simple_note/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
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
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: FutureBuilder(
          future: _databaseService.getNotes(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const Center(child: Text('No notes available'))
                : ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Note note = snapshot.data![index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Dismissible(
                          key: Key(note.title),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              deleteNote(index);
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              // Implement archive action here
                            }
                          },
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            color: const Color.fromRGBO(175, 23, 64, 1),
                            child: const Icon(Icons.delete,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 40),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            color: const Color.fromRGBO(49, 81, 30, 1),
                            child: const Icon(Icons.archive,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 40),
                          ),
                          child: NoteCard(note: note, createNote: createNote),
                        ),
                      );
                    },
                  );
          }),
      floatingActionButton: NoteAddButton(createNote: createNote),
    );
  }

  void createNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
}
