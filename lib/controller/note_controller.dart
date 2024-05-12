// ignore_for_file: no_leading_underscores_for_local_identifiers, await_only_futures, avoid_print

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note_appv2/model/note_model.dart';
import 'package:path_provider/path_provider.dart';

class NoteController with ChangeNotifier {
  // ... Object Of Isar
  static late Isar obj;
  // ... Get Directory & Schema
  static Future<void> intializer() async {
    final directory = await getApplicationDocumentsDirectory();
    obj = await Isar.open(
      [NoteSchema],
      directory: directory.path,
    );
  }

  // ... List Of Notes
  final List<Note> currentNotes = [];
  // ... Create Notes
  Future<void> addNotes(
      String _title, String _description, DateTime _dateTime) async {
    final newNote = await Note()
      ..title = _title
      ..description = _description
      ..dateTime = _dateTime;
    await obj.writeTxn(() => obj.notes.put(newNote));
    readNotes();
  }

  // ... Read Notes
  Future<void> readNotes() async {
    List<Note> _readNote = await obj.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(_readNote);
    notifyListeners();
  }

  // ... Update Note
  Future<void> updateNotes(
      int _id, String _title, String _description, DateTime _dateTime) async {
    final oldNote = await obj.notes.get(_id);
    if (oldNote != null) {
      oldNote.title = _title;
      oldNote.description = _description;
      oldNote.dateTime = _dateTime;
      await obj.writeTxn(() => obj.notes.put(oldNote));
      await readNotes();
    }
  }

  // ... Delete Notes
  Future<void> deleteNote(int _id) async {
    await obj.writeTxn(() => obj.notes.delete(_id));
    await readNotes();
  }

  // ... Search Function
  Future<void> searchIsar(String searchString) async {
    var result =
        await obj.notes.where().filter().titleContains(searchString).findAll();
    if (result.isEmpty) {
      print("No Matching Result Found");
    } else {
      print("Matching Result");
      for (var element in result) {
        print(element.title);
      }
    }
  }
}
