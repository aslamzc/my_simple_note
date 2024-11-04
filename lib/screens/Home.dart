import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';
import 'package:my_simple_note/screens/create_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              setState(() {
                final theme = value ? ThemeData.dark() : ThemeData.light();
                runApp(
                  MaterialApp(
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
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Deleted'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes available'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Dismissible(
                    key: Key(notes[index].title),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        deleteNote(index);
                      } else if (direction == DismissDirection.endToStart) {
                        // Implement archive action here
                      }
                    },
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      color: const Color.fromRGBO(175, 23, 64, 1),
                      child: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 255, 255, 255), size: 40),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: const Color.fromRGBO(133, 159, 61, 1),
                      child: const Icon(Icons.archive,
                          color: Color.fromARGB(255, 255, 255, 255), size: 40),
                    ),
                    child: Card(
                      color: const Color.fromRGBO(233, 238, 217, 1),
                      child: SizedBox(
                        height: 120,
                        child: ListTile(
                          title: Text(
                            notes[index].title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Roboto',
                              color: Color.fromARGB(255, 53, 51, 1),
                            ),
                          ),
                          subtitle: Text(
                            notes[index].note,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              color: Color.fromARGB(255, 53, 51, 1),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                pageBuilder: (_, __, ___) =>
                                    CreateNote(onCreateNote: createNote),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOutCubic,
                                    )),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(233, 238, 217, 1),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) => CreateNote(onCreateNote: createNote),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Color.fromARGB(255, 53, 51, 1)),
      ),
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
