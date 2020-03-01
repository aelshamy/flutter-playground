import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/appointments/bloc/appointments_bloc.dart';
import 'package:flutter_book/appointments/ui/appointments_list.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/ui/notes_list.dart';
import 'package:flutter_book/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_book/tasks/ui/tasks_list.dart';

class FlutterBook extends StatelessWidget {
  Widget build(BuildContext inContext) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FlutterBook"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.date_range), text: "Appointments"),
                // Tab(icon: Icon(Icons.contacts), text: "Contacts"),
                Tab(icon: Icon(Icons.note), text: "Notes"),
                Tab(icon: Icon(Icons.assignment_turned_in), text: "Tasks")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Contacts(),
              BlocProvider<AppointmentsBloc>(
                create: (context) => AppointmentsBloc()..add(LoadAppointments()),
                child: AppointmentsList(),
              ),
              BlocProvider<NotesBloc>(
                create: (context) => NotesBloc()..add(LoadNotes()),
                child: NotesList(),
              ),
              BlocProvider<TasksBloc>(
                create: (context) => TasksBloc()..add(LoadTasks()),
                child: TasksList(),
              ),
              // Tasks(),
            ],
          ),
        ),
      ),
    );
  }
}
