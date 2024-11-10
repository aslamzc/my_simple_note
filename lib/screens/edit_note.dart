import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';
import 'package:my_simple_note/screens/Home.dart';
import 'package:my_simple_note/services/database_service.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.note});

  final Note note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final DatabaseService _databaseService = DatabaseService.instance;

  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    noteController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note',
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
          _databaseService.updateNote({
            "id": widget.note.id,
            "title": titleController.text,
            "content": noteController.text,
            "status": widget.note.status,
            "updated_date": DateTime.now().toString(),
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: const Icon(Icons.save, color: Color.fromARGB(255, 53, 51, 1)),
      ),
    );
  }
}
