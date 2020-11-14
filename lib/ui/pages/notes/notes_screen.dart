import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/pages/notes/note_form.dart';
import 'package:notes/ui/widgets/notes/notes_grid.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key key}) : super(key: key);

  static const String routeName = '/notes';

  @override
  Widget build(BuildContext context) {
    Provider.of<NotesRepository>(context, listen: false).fetchNotes();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notes',
        ),
      ),
      body: NotesGrid(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(NoteForm()),
      ),
    );
  }

  _handleGoToNewNote(context) {
    Navigator.of(context).pushNamed(NoteForm.routeName);
  }
}
