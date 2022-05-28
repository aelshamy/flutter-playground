import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/note.dart';
import 'package:flutter_book/notes/ui/note_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (BuildContext context, int inIndex) {
                Note note = state.notes[inIndex];
                return Dismissible(
                  key: ValueKey(note.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete),
                  ),
                  confirmDismiss: (direction) =>
                      _confirmDismiss(context, note.title!),
                  onDismissed: (direction) => _deleteNote(context, note),
                  child: Card(
                    elevation: 1,
                    color: Note.colors[note.color],
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      title: Text(
                        note.title ?? "",
                        style: const TextStyle(
                          height: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      subtitle: Text(
                        note.content?.trim() ?? "",
                        style:
                            const TextStyle(height: 1.4, color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<NotesBloc>(context),
                              child: NoteItem(note: note),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<NotesBloc>(context),
                child: const NoteItem(note: Note()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteNote(BuildContext context, Note note) async {
    BlocProvider.of<NotesBloc>(context).add(DeleteNote(noteId: note.id!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text("Note deleted"),
      ),
    );
  }

  Future<bool> _confirmDismiss(BuildContext context, String noteTitle) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: const Text("Delete Note"),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                const TextSpan(text: 'Are you sure you want to delete "'),
                TextSpan(
                    text: noteTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: '"?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(inAlertContext).pop(false);
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                Navigator.of(inAlertContext).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}
