import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/entities/priority.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/actions/delete_note_dialog.dart';
import 'package:notes/ui/pages/notes/note_form.dart';
import 'package:notes/ui/utils/priorities_colors.dart';
import 'package:provider/provider.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({Key key}) : super(key: key);

  static const String routeName = '/note-details';

  @override
  Widget build(BuildContext context) {
    final notesRepository = Provider.of<NotesRepository>(context);

    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          data['title'],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _handleDeleteNote(data['id'], context),
            icon: Icon(Icons.delete_outline),
          )
        ],
      ),
      body: FutureBuilder(
        future: notesRepository.fetchNote(data['id']),
        builder: (context, AsyncSnapshot<Note> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingProgress();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && !snapshot.hasError) {
              final note = snapshot.data;
              return _buildNoteContent(note, context);
            } else {
              return _buildErrorMessage(context);
            }
          } else {
            return _buildErrorMessage(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleGoToEditNote(context, data),
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNoteContent(Note note, context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildNoteTitle(note.title, note.priority, note.completed, context),
          ..._buildDivider(context),
          _buildNoteDescription(note.description, context),
          const SizedBox(height: 24),
          _buildNoteCreatedAtDate(note, context),
        ],
      ),
    );
  }

  Widget _buildNoteTitle(
      String title, String priority, bool completed, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 36),
              textAlign: TextAlign.start,
            ),
            Icon(
              completed ? Icons.check : Icons.close,
              color: completed ? Colors.green : Colors.red,
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: PrioritiesColors.getColorByPriority(
            priority: Priorities.stringToEnum(priority),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteDescription(String description, context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
      textAlign: TextAlign.justify,
    );
  }

  List<Widget> _buildDivider(context) {
    return [
      const SizedBox(height: 12),
      Divider(color: Theme.of(context).primaryColorLight),
      const SizedBox(height: 12)
    ];
  }

  Widget _buildNoteCreatedAtDate(Note note, context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.event,
          color: Theme.of(context).primaryColorLight,
        ),
        const SizedBox(width: 8),
        Text(
          DateFormat.yMEd().format(DateTime.parse(note.createdAt)),
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 15),
        ),
        _buildToggleCompletedChip(note, context),
      ],
    );
  }

  Widget _buildToggleCompletedChip(Note note, context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: InputChip(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          avatar: Icon(
            note.completed ? Icons.close : Icons.check,
            color: note.completed ? Colors.red : Colors.green,
          ),
          label: Text(
            note.completed ? 'Mask as Undone' : 'Mask as Done',
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 15,
                  color: Colors.black,
                ),
          ),
          onPressed: () => _handleToggleNoteCompleted(
            note.copyWith(completed: !note.completed),
            context,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorMessage(context) {
    return Center(
      child: Text(
        'No Note Found',
        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 26.0),
      ),
    );
  }

  _handleDeleteNote(int id, context) {
    final notesRepository =
        Provider.of<NotesRepository>(context, listen: false);
    final note = notesRepository.note(id);
    return DeleteNoteDialog.showDeleteNoteDialog(
      context,
      "Delete '${note.title}' note",
      "Are you sure you want to delete this note?",
      [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () async {
            await notesRepository.deleteNote(note);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('DELETE'),
        ),
      ],
    );
  }

  _handleToggleNoteCompleted(Note note, context) async {
    await Provider.of<NotesRepository>(context, listen: false).saveNote(note);
  }

  _handleGoToEditNote(context, Map<String, dynamic> data) {
    Navigator.of(context).pushNamed(NoteForm.routeName, arguments: {
      'id': data['id'],
      'title': data['title'],
    });
  }
}
