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
      body: notes.isEmpty
          ? const Center(child: Text('No notes available'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Dismissible(
                    key: Key(notes[index].title),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      deleteNote(index);
                    },
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      color: const Color.fromRGBO(175, 23, 64, 1),
                      child: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 40),
                    ),
                    child: Card(
                      color: const Color.fromRGBO(233, 238, 217, 1),
                      child: SizedBox(
                        height: 120,
                        child: ListTile(
                          title: Text(notes[index].title),
                          subtitle: Text(notes[index].note),
                          trailing: IconButton(
                            icon: const Icon(Icons.archive),
                            onPressed: () {
                              deleteNote(index);
                            },
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
        child: const Icon(Icons.add),
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
