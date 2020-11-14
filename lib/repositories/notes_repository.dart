import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/database/daos/note_dao.dart';
import 'package:notes/entities/note.dart';

class NotesRepository with ChangeNotifier {
  final NoteDAO noteDAO;
  final FirebaseFirestore firestore;

  NotesRepository({
    @required this.noteDAO,
    @required this.firestore,
  });

  List<Note> _notes = [];

  List<Note> get notes => [..._notes];

  Note note(int id) => _notes.firstWhere((note) => note.id == id).copyWith();

  fetchNotes() async {
    List<Note> data = await noteDAO.fetchNotes();
    _notes.clear();
    _notes.addAll(data);
    notifyListeners();
  }

  Future<void> saveNote(Note note) async {
    if (note.id == null) {
      int id = await noteDAO.insertNote(note);
      _notes.add(note.copyWith(id: id));
      firestore
          .collection('notes')
          .doc(id.toString())
          .set(note.copyWith(id: id).toMap());
    } else {
      await noteDAO.updateNote(note);
      int position = _notes.indexWhere((element) => element.id == note.id);
      _notes[position] = note;
      firestore.collection('notes').doc(note.id.toString()).set(note.toMap());
    }
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    await noteDAO.deleteNote(note);
    int position = _notes.indexWhere((element) => element.id == note.id);
    firestore.collection('notes').doc(note.id.toString()).delete();
    _notes.removeAt(position);
    notifyListeners();
  }

  Future<Note> fetchNote(int id) => noteDAO.fetchNote(id);
}
