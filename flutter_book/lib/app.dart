import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/notes_list.dart';

class FlutterBook extends StatelessWidget {
  Widget build(BuildContext inContext) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FlutterBook"),
            bottom: TabBar(
              tabs: [
                // Tab(icon: Icon(Icons.date_range), text: "Appointments"),
                // Tab(icon: Icon(Icons.contacts), text: "Contacts"),
                Tab(icon: Icon(Icons.note), text: "Notes"),
                // Tab(icon: Icon(Icons.assignment_turned_in), text: "Tasks")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Appointments(),
              // Contacts(),
              BlocProvider<NotesBloc>(
                create: (context) => NotesBloc()..add(LoadNotes()),
                child: NotesList(),
              ),
              // Tasks(),
            ],
          ),
        ),
      ),
    );
  }
}
