import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/appointments/bloc/appointments_bloc.dart';
import 'package:flutter_book/appointments/ui/appointments_list.dart';
import 'package:flutter_book/contacts/bloc/contacts_bloc.dart';
import 'package:flutter_book/contacts/ui/contacts_list.dart';
import 'package:flutter_book/notes/bloc/notes_bloc.dart';
import 'package:flutter_book/notes/ui/notes_list.dart';
import 'package:flutter_book/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_book/tasks/ui/tasks_list.dart';

class FlutterBook extends StatelessWidget {
  const FlutterBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("FlutterBook"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.date_range), text: "Appointments"),
                Tab(icon: Icon(Icons.contacts), text: "Contacts"),
                Tab(icon: Icon(Icons.note), text: "Notes"),
                Tab(icon: Icon(Icons.assignment_turned_in), text: "Tasks")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocProvider<AppointmentsBloc>(
                create: (context) =>
                    AppointmentsBloc()..add(LoadAppointments()),
                child: const AppointmentsList(),
              ),
              BlocProvider<ContactsBloc>(
                create: (context) => ContactsBloc()..add(LoadContacts()),
                child: const ContactsList(),
              ),
              BlocProvider<NotesBloc>(
                create: (context) => NotesBloc()..add(LoadNotes()),
                child: const NotesList(),
              ),
              BlocProvider<TasksBloc>(
                create: (context) => TasksBloc()..add(LoadTasks()),
                child: const TasksList(),
              ),
              // Tasks(),
            ],
          ),
        ),
      ),
    );
  }
}
