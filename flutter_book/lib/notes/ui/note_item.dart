import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/note.dart';

class NoteItem extends StatefulWidget {
  final Note note;

  NoteItem({Key key, this.note}) : super(key: key);

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  TextEditingController _titleEditingController;
  TextEditingController _contentEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _color;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.note.title);
    _contentEditingController = TextEditingController(text: widget.note.content);
    _color = Note.colors[widget.note.color];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.title),
              title: TextFormField(
                decoration: InputDecoration(hintText: "Title"),
                controller: _titleEditingController,
                validator: (String inValue) {
                  if (inValue.length == 0) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.content_paste),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(hintText: "Content"),
                controller: _contentEditingController,
                validator: (String inValue) {
                  if (inValue.length == 0) {
                    return "Please enter content";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: ButtonBar(
                buttonPadding: EdgeInsets.all(2),
                alignment: MainAxisAlignment.spaceBetween,
                children: Note.colors.values.map((Color value) => _colorButton(value)).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton.icon(
              label: Text("Cancel"),
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (context) => FlatButton.icon(
                label: Text("Save"),
                icon: Icon(
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
    if (_formKey.currentState.validate()) {
      final currentColor =
          Note.colors.keys.firstWhere((k) => Note.colors[k] == _color, orElse: () => null);
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
            note: Note(
              id: widget.note.id,
              content: _contentEditingController.text,
              color: currentColor,
              title: _titleEditingController.text,
            ),
          ),
        );
      }

      await Scaffold.of(context)
          .showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Note saved"),
            ),
          )
          .closed;
      Navigator.of(context).pop();
    }
  }
}
