import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';
import 'package:my_simple_note/screens/edit_note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) => EditNote(note: note),
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
        child: Card(
          color: const Color.fromRGBO(166, 174, 191, 1),
          child: SizedBox(
            height: 120,
            child: ListTile(
              title: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 53, 51, 1),
                ),
              ),
              subtitle: Text(
                note.content,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 53, 51, 1),
                ),
              ),
            ),
          ),
        ));
  }
}
