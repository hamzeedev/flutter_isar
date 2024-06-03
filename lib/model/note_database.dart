import 'package:flutter/material.dart';
import 'package:flutter_isar/model/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // ! intialize Database
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path
      );
  }
  //  list of notes
  final List<Note> currentNotes = [];

  // ! Create - - -
  Future<void> addNote(String textFromUser) async{
    // create a new object
    final newNote = Note()..text = textFromUser;
    // save to data base
    await isar.writeTxn(()=> isar.notes.put(newNote));
    // re-read from database 
    fetchNotes();
  }

  // ! Read - - -
  Future<void> fetchNotes() async{
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    
    notifyListeners();
  }

  // ! Update - - -
  Future<void> updateNote(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if (existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(()=> isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // ! Delete - - -
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(()=> isar.notes.delete(id));
    await fetchNotes();
  }
}