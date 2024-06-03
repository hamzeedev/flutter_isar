import 'package:flutter/material.dart';
import 'package:flutter_isar/model/note.dart';
import 'package:flutter_isar/model/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller to access what the user typed...
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // when app strats, fetch the existing ones...
    readNotes();
  }

  // ! Create
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                // create button
                MaterialButton(
                  onPressed: () {
                    // add to database...
                    context.read<NoteDatabase>().addNote(textController.text);
                    // clear controler
                    textController.clear();
                    // pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                )
              ],
            ));
  }

  // ! Read
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }
  // ! Update

  void updateNotes(Note note){
    // pre-fill th current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder:(context) => AlertDialog(
        title: const Text('Update Note'),
              content: TextField(controller: textController,),
              actions: [
                // update button
                MaterialButton(
                  onPressed: () {
                    // add to database...
                    context
                    .read<NoteDatabase>()
                    .updateNote(note.id, textController.text);
                    // clear controler
                    textController.clear();
                    // pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            )
      );
  }

  // ! Delete
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }


  @override
  Widget build(BuildContext context) {
    // note database ...
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> currentNote = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,title: const Text('Notes'), ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNote.length,
        itemBuilder: (context, index) {
        // get individual note
        final note = currentNote[index];
        // list tile ui
        return ListTile(
          title: Text(note.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // edit button
              IconButton(
                onPressed: ()=> updateNotes(note),
                icon: const Icon(Icons.edit),
              ),
              // delete button
              IconButton(
                onPressed: ()=> deleteNote(note.id),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      }),
    );
  }
}
