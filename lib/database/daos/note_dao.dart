import 'package:floor/floor.dart';
import 'package:notes/entities/note.dart';

@dao
abstract class NoteDAO {
  @Query("SELECT * FROM Note")
  Future<List<Note>> fetchNotes();

  @insert
  Future<int> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @Query("SELECT * FROM Note WHERE id = :id")
  Future<Note> fetchNote(int id);
}
