import 'package:flutter/material.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/entities/priority.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/actions/delete_note_dialog.dart';
import 'package:notes/ui/pages/notes/note_details.dart';
import 'package:notes/ui/utils/priorities_colors.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final int position;
  const NoteItem({
    Key key,
    @required this.note,
    @required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: this.key,
      direction: this._setDirection(),
      confirmDismiss: (direction) => this._handleDeleteNote(context),
      child: _buildNoteBody(context),
    );
  }

  Widget _buildNoteBody(context) {
    return Card(
      shape: _buildCompletedIndicator(),
      margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _handleGoToDetails(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildNoteTitle(context),
                  SizedBox(
                    height: 8,
                  ),
                  _buildNoteDescription(context),
                ],
              ),
            ),
            _buildNotePriorityIndicator(),
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder _buildCompletedIndicator() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: note.completed ? Colors.green : Colors.red,
        width: 12,
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }

  Widget _buildNoteTitle(context) {
    return Text(
      note.title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNoteDescription(context) {
    return Text(
      note.description,
      maxLines: 4,
      style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14),
      overflow: TextOverflow.fade,
    );
  }

  Widget _buildNotePriorityIndicator() {
    return Positioned(
      top: 8,
      left: 8,
      child: CircleAvatar(
        backgroundColor: PrioritiesColors.getColorByPriority(
          priority: Priorities.stringToEnum(note.priority),
        ),
        radius: 10,
      ),
    );
  }

  _handleGoToDetails(context) {
    Navigator.of(context).pushNamed(NoteDetails.routeName, arguments: {
      'id': note.id,
      'title': note.title,
    });
  }

  Future<bool> _handleDeleteNote(context) {
    return DeleteNoteDialog.showDeleteNoteDialog(
      context,
      "Delete '${note.title}' note",
      "Are you sure you want to delete this note?",
      [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            return false;
          },
          child: Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () => _deleteNote(context),
          child: Text('DELETE'),
        ),
      ],
    );
  }

  Future<void> _deleteNote(context) async {
    final notesRepository =
        Provider.of<NotesRepository>(context, listen: false);
    await notesRepository.deleteNote(note);
    Navigator.of(context).pop();
    return true;
  }

  DismissDirection _setDirection() {
    if (this.position % 2 == 0) {
      return DismissDirection.endToStart;
    } else
      return DismissDirection.startToEnd;
  }
}
