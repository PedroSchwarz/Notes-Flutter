import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/database/app_database.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/ui/pages/notes/note_details.dart';
import 'package:notes/ui/pages/notes/note_form.dart';
import 'package:notes/ui/pages/notes/notes_screen.dart';
import 'package:notes/ui/themes/app_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.initializeDatabase();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppDatabase _database = AppDatabase.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return ChangeNotifierProvider(
      create: (builder) => NotesRepository(
        noteDAO: _database.noteDAO,
        firestore: _firestore,
      ),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lighTheme,
        darkTheme: AppThemes.darkTheme,
        home: NotesScreen(),
        routes: {
          NotesScreen.routeName: (builder) => NotesScreen(),
          NoteForm.routeName: (builder) => NoteForm(),
          NoteDetails.routeName: (builder) => NoteDetails(),
        },
      ),
    );
  }
}
