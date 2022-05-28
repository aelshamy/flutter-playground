import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/bloc/appointments_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentItem extends StatefulWidget {
  final Appointment appointment;
  const AppointmentItem({Key? key, required this.appointment})
      : super(key: key);

  @override
  AppointmentItemState createState() => AppointmentItemState();
}

class AppointmentItemState extends State<AppointmentItem> {
  late final TextEditingController _titleEditingController;
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _appointmentDateEditingController;
  late final TextEditingController _appointmentTimeEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleEditingController =
        TextEditingController(text: widget.appointment.title);
    _descriptionEditingController =
        TextEditingController(text: widget.appointment.description);
    _appointmentDateEditingController =
        TextEditingController(text: widget.appointment.appointmentDate);
    _appointmentTimeEditingController =
        TextEditingController(text: widget.appointment.appointmentTime);
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
              leading: const Icon(Icons.description),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(hintText: "Description"),
                controller: _descriptionEditingController,
                validator: (String? inValue) {
                  if (inValue?.isEmpty == true) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Date",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () async {
                      String selectedDate = await _selectDate(context);
                      _appointmentDateEditingController.text = selectedDate;
                    },
                  ),
                ),
                controller: _appointmentDateEditingController,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Time",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () async {
                      String selectedDate = await _selectTime(context);
                      _appointmentTimeEditingController.text = selectedDate;
                    },
                  ),
                ),
                controller: _appointmentTimeEditingController,
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

  Future _selectTime(BuildContext inContext) async {
    TimeOfDay initialTime = TimeOfDay.now();

    final timeDateFormat =
        DateFormat.jm("en_US").parse(widget.appointment.appointmentTime);
    initialTime = TimeOfDay.fromDateTime(timeDateFormat);

    TimeOfDay? picked =
        await showTimePicker(context: inContext, initialTime: initialTime);

    return DateFormat.jm("en_US").format(
        DateFormat.Hm("en_US").parse("${picked!.hour}:${picked.minute}"));
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    initialDate =
        DateFormat.yMMMMd("en_US").parse(widget.appointment.appointmentDate);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    return DateFormat.yMMMMd("en_US").format(picked!.toLocal());
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      if (widget.appointment.id > 0) {
        BlocProvider.of<AppointmentsBloc>(context).add(
          AddAppointment(
            appointment: Appointment(
              title: _titleEditingController.text,
              description: _descriptionEditingController.text,
              appointmentDate: _appointmentDateEditingController.text,
              appointmentTime: _appointmentTimeEditingController.text,
            ),
          ),
        );
      } else {
        BlocProvider.of<AppointmentsBloc>(context).add(
          UpdateAppointment(
            appointment: widget.appointment.copyWith(
              title: _titleEditingController.text,
              description: _descriptionEditingController.text,
              appointmentDate: _appointmentDateEditingController.text,
              appointmentTime: _appointmentTimeEditingController.text,
            ),
          ),
        );
      }

      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Appointment saved"),
            ),
          )
          .closed;
    }
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    _appointmentDateEditingController.dispose();
    _appointmentTimeEditingController.dispose();
    super.dispose();
  }
}
