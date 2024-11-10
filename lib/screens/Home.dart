import 'package:flutter/material.dart';
import 'package:my_simple_note/models/Note.dart';
import 'package:my_simple_note/screens/widgets/card_background.dart';
import 'package:my_simple_note/screens/widgets/card_background_2.dart';
import 'package:my_simple_note/screens/widgets/left_menu.dart';
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
      drawer: const LeftMenu(),
      body: FutureBuilder(
          future: _databaseService.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return snapshot.hasData && snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Note note = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              _databaseService
                                  .deleteNote(note.id!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Note deleted')));
                                setState(() {});
                              });
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              _databaseService
                                  .archiveNote(note.id!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Note archived')));
                                setState(() {});
                              });
                            }
                          },
                          background: const CardBackground(),
                          secondaryBackground: const CardBackground2(),
                          child: NoteCard(note: note),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No notes available'));
          }),
      floatingActionButton: const NoteAddButton(),
    );
  }
}
