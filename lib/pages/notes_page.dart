import 'package:flutter/material.dart';
import 'package:flutter_isar/components/drawer.dart';
import 'package:flutter_isar/components/note_tile.dart';
import 'package:flutter_isar/model/note.dart';
import 'package:flutter_isar/model/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
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
          backgroundColor: Theme.of(context).colorScheme.surface,
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
        backgroundColor: Theme.of(context).colorScheme.surface,
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
      
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,foregroundColor: Theme.of(context).colorScheme.inversePrimary,),
      
      backgroundColor: Theme.of(context).colorScheme.surface,
      
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child:  Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,),
        ),
      
      drawer: const MyDrawer(),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
           Padding(
            padding: const EdgeInsets.only(left:25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ),
            ),

          // Notes list
          Expanded(
          child: ListView.builder(
            itemCount: currentNote.length,
            itemBuilder: (context, index) {
            // get individual note
            final note = currentNote[index];
            // list tile ui
            return NoteTile(
              text: note.text,
              onEditPressed: ()=> updateNotes(note),
              onDeletePressed: () => deleteNote(note.id),
            );
          }),
        ),
        ],
        
      ),
    );
  }
}
