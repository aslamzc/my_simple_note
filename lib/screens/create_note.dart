import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onCreateNote});

  final Function(Note) onCreateNote;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              autofocus: true,
              maxLines: 1,
            ),
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: 'Note',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(166, 174, 191, 1),
        onPressed: () {
          if (titleController.text.isEmpty || noteController.text.isEmpty) {
            return;
          }
          widget.onCreateNote(Note(
            title: titleController.text,
            note: noteController.text,
          ));
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save, color: Color.fromARGB(255, 53, 51, 1)),
      ),
    );
  }
}
