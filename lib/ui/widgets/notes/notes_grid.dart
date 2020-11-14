import 'package:flutter/material.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/widgets/notes/note_item.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesRepository = Provider.of<NotesRepository>(context);
    return _buildContent(notesRepository.notes, context);
  }

  Widget _buildContent(List<Note> notes, context) {
    if (notes.length <= 0) {
      return _buildEmptyList(context);
    } else {
      return GridView.builder(
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, int position) {
          final note = notes[position];
          return NoteItem(
            key: ValueKey('note_item_${note.id}'),
            note: note,
            position: position,
          );
        },
      );
    }
  }

  Widget _buildEmptyList(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.dashboard,
            size: 56,
            color: Theme.of(context).primaryColorLight,
          ),
          Text(
            'No Notes found',
            style:
                Theme.of(context).textTheme.headline1.copyWith(fontSize: 26.0),
          ),
        ],
      ),
    );
  }
}
