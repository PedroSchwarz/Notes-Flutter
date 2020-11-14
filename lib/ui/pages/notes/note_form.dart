import 'package:flutter/material.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/validators/form_validators.dart';
import 'package:notes/ui/widgets/notes/note_chips_inputs.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  NoteForm({Key key}) : super(key: key);

  static const String routeName = '/note-form';

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _isInit = true;

  Note _note = Note();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      checkIfIsEdit();
    }
  }

  checkIfIsEdit() {
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      _fetchNote(data['id']);
    }
    _isInit = false;
  }

  _fetchNote(int id) {
    _note = Provider.of<NotesRepository>(context).note(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Note'),
        centerTitle: true,
      ),
      body: Form(
        key: _formState,
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0),
          children: [
            ListTile(
              title: TextFormField(
                key: ValueKey('form_title'),
                decoration: _buildInputDecoration('Title'),
                textCapitalization: TextCapitalization.words,
                initialValue: _note.title,
                onSaved: (String value) {
                  this._note = this._note.copyWith(title: value.trim());
                },
                validator: FormValidators.validateSimpleInput,
              ),
            ),
            ListTile(
              title: TextFormField(
                key: ValueKey('form_description'),
                decoration: _buildInputDecoration('Description'),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 8,
                initialValue: _note.description,
                onSaved: (String value) {
                  this._note = this._note.copyWith(description: value.trim());
                },
                validator: FormValidators.validateMultiInput,
              ),
            ),
            NoteChipsInputs(
              selectedValue: _note.priority,
              onSelected: (priority) {
                setState(
                  () {
                    _note = _note.copyWith(priority: priority);
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _validateData,
        child: Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      labelStyle: Theme.of(context).textTheme.subtitle1,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  _validateData() async {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
      final notesRepository =
          Provider.of<NotesRepository>(context, listen: false);
      await notesRepository.saveNote(_note);
      _goBack();
    }
  }

  _goBack() {
    Navigator.of(context).pop();
  }
}
