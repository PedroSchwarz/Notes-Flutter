import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:notes/database/daos/note_dao.dart';
import 'package:notes/entities/note.dart';

part 'app_database.g.dart';

const _DATABASE_NAME = 'notes.db';

@Database(entities: [Note], version: 1)
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDAO;

  static AppDatabase _instance;

  static Future<void> initializeDatabase() async {
    if (_instance == null) {
      _instance =
          await $FloorAppDatabase.databaseBuilder(_DATABASE_NAME).build();
    }
  }

  static get instance => _instance;
}
