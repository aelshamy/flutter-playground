import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/note.dart';

class NoteItem extends StatefulWidget {
  final Note note;

  const NoteItem({Key? key, required this.note}) : super(key: key);

  @override
  NoteItemState createState() => NoteItemState();
}

class NoteItemState extends State<NoteItem> {
  late final TextEditingController _titleEditingController;
  late final TextEditingController _contentEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final Color _color;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.note.title);
    _contentEditingController =
        TextEditingController(text: widget.note.content);
    _color = Note.colors[widget.note.color]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Title"),
                controller: _titleEditingController,
                validator: (String? inValue) {
                  if (inValue?.isEmpty == true) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: const InputDecoration(hintText: "Content"),
                controller: _contentEditingController,
                validator: (String? inValue) {
                  if (inValue?.isEmpty == true) {
                    return "Please enter content";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: ButtonBar(
                buttonPadding: const EdgeInsets.all(2),
                alignment: MainAxisAlignment.spaceBetween,
                children: Note.colors.values
                    .map((Color value) => _colorButton(value))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              label: const Text("Cancel"),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (context) => TextButton.icon(
                label: const Text("Save"),
                icon: const Icon(
                  Icons.save,
                  color: Colors.green,
                ),
                onPressed: () {
                  _save(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: color,
          border: _color == color
              ? Border.all(
                  width: 4,
                  color: Colors.black54,
                )
              : null,
        ),
      ),
      onTap: () {
        setState(() {
          _color = color;
        });
      },
    );
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      final currentColor = Note.colors[_color];
      if (widget.note.id == null) {
        BlocProvider.of<NotesBloc>(context).add(
          AddNote(
            note: Note(
              content: _contentEditingController.text,
              color: currentColor,
              title: _titleEditingController.text,
            ),
          ),
        );
      } else {
        BlocProvider.of<NotesBloc>(context).add(
          UpdateNote(
            note: widget.note.copyWith(
              content: _contentEditingController.text,
              color: currentColor,
              title: _titleEditingController.text,
            ),
          ),
        );
      }

      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Note saved"),
            ),
          )
          .closed;
    }
  }

  @override
  void dispose() {
    _contentEditingController.dispose();
    _titleEditingController.dispose();
    super.dispose();
  }
}
