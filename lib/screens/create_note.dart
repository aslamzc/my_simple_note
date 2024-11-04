import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

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
        title: const Text('Add Note'),
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
    );
  }
}
