import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/bloc/appointments_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentItem extends StatefulWidget {
  final Appointment appointment;
  const AppointmentItem({Key key, this.appointment}) : super(key: key);

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  TextEditingController _titleEditingController;
  TextEditingController _descriptionEditingController;
  TextEditingController _appointmentDateEditingController;
  TextEditingController _appointmentTimeEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.appointment.title);
    _descriptionEditingController = TextEditingController(text: widget.appointment.description);
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
              leading: Icon(Icons.description),
              title: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(hintText: "Description"),
                controller: _descriptionEditingController,
                validator: (String inValue) {
                  if (inValue.length == 0) {
                    return "Please enter aescription";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Date",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
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
              leading: Icon(Icons.alarm),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Time",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
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

  Future _selectTime(BuildContext inContext) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (widget.appointment.appointmentTime != null) {
      final timeDateFormat = DateFormat.jm("en_US").parse(widget.appointment.appointmentTime);
      initialTime = TimeOfDay.fromDateTime(timeDateFormat);
    }

    TimeOfDay picked = await showTimePicker(context: inContext, initialTime: initialTime);

    if (picked != null) {
      return DateFormat.jm("en_US")
          .format(DateFormat.Hm("en_US").parse("${picked.hour}:${picked.minute}"));
    }
    return null;
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (widget.appointment.appointmentDate != null) {
      initialDate = DateFormat.yMMMMd("en_US").parse(widget.appointment.appointmentDate);
    }
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      return DateFormat.yMMMMd("en_US").format(picked.toLocal());
    }
    return null;
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (widget.appointment.id == null) {
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
            appointment: Appointment(
              id: widget.appointment.id,
              title: _titleEditingController.text,
              description: _descriptionEditingController.text,
              appointmentDate: _appointmentDateEditingController.text,
              appointmentTime: _appointmentTimeEditingController.text,
            ),
          ),
        );
      }

      await Scaffold.of(context)
          .showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Appointment saved"),
            ),
          )
          .closed;
      Navigator.of(context).pop();
    }
  }
}
