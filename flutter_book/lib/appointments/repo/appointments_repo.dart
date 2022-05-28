import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/repo/appointments_provider.dart';

class AppointmentsRepo {
  final AppointmentsProvider _appointmentsProvider;
  AppointmentsRepo({AppointmentsProvider? appointmentsProvider})
      : _appointmentsProvider = appointmentsProvider ?? AppointmentsProvider();

  Future<List<Appointment>> getAll() {
    return _appointmentsProvider.getAll();
  }

  Future<int> addAppointment(Appointment appointment) {
    return _appointmentsProvider.create(appointment);
  }

  Future<int> updateAppointment(Appointment appointment) {
    return _appointmentsProvider.update(appointment);
  }

  Future<int> deleteAppointment(int appointmentId) {
    return _appointmentsProvider.delete(appointmentId);
  }
}
