import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/bloc/appointments_bloc.dart';
import 'package:flutter_book/appointments/ui/appointment_item.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (context, state) {
          if (state is AppointmentsLoaded) {
            EventList<Event> markedDateMap = EventList(events: {});
            for (var appointment in state.appointments) {
              final appDate =
                  DateFormat.yMMMMd("en_US").parse(appointment.appointmentDate);
              markedDateMap.add(
                appDate,
                Event(
                  date: appDate,
                  icon: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                  ),
                ),
              );
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: CalendarCarousel<Event>(
                      thisMonthDayBorderColor: Colors.grey,
                      daysHaveCircularBorder: false,
                      markedDatesMap: markedDateMap,
                      onDayPressed: (DateTime inDate, List<Event> inEvents) {
                        _showAppointments(context, inDate, state.appointments);
                      },
                    ),
                  ),
                ),
              ],
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
                value: BlocProvider.of<AppointmentsBloc>(context),
                child: const AppointmentItem(appointment: Appointment()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAppointments(BuildContext inContext, DateTime inDate,
      List<Appointment> appointments) async {
    showModalBottomSheet(
      context: inContext,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                DateFormat.yMMMMd("en_US").format(inDate.toLocal()),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 15),
                itemCount: appointments.length,
                itemBuilder: (BuildContext inBuildContext, int inIndex) {
                  Appointment appointment = appointments[inIndex];
                  if (appointment.appointmentDate !=
                      DateFormat.yMMMMd("en_US").format(inDate.toLocal())) {
                    return const SizedBox();
                  }

                  return Dismissible(
                    key: ValueKey(appointment.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete),
                    ),
                    confirmDismiss: (direction) =>
                        _confirmDismiss(inContext, appointment.description),
                    onDismissed: (direction) =>
                        _deleteAppointment(inContext, appointment),
                    child: ListTile(
                      // trailing: Text("${appointment.appointmentTime}"),
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: StringUtils.capitalize(
                                  "${appointment.title}\n"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(
                              text: "${appointment.appointmentTime}\n",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  height: 2),
                            )
                          ],
                        ),
                      ),
                      subtitle: Text(appointment.description),
                      onTap: () async {
                        Navigator.of(inContext).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value:
                                  BlocProvider.of<AppointmentsBloc>(inContext),
                              child: AppointmentItem(appointment: appointment),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAppointment(BuildContext context, Appointment appointment) async {
    BlocProvider.of<AppointmentsBloc>(context)
        .add(DeleteAppointment(appointmentId: appointment.id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text("Task deleted"),
      ),
    );
  }

  Future<bool> _confirmDismiss(
      BuildContext context, String appointmentDescription) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                const TextSpan(text: 'Are you sure you want to delete "'),
                TextSpan(
                    text: appointmentDescription,
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
