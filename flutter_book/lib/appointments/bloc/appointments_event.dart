part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class LoadAppointments extends AppointmentsEvent {
  @override
  List<Object> get props => [];
}

class DeleteAppointment extends AppointmentsEvent {
  final int appointmentId;

  DeleteAppointment({this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}

class AddAppointment extends AppointmentsEvent {
  final Appointment appointment;

  AddAppointment({this.appointment});

  @override
  List<Object> get props => [appointment];
}

class UpdateAppointment extends AppointmentsEvent {
  final Appointment appointment;

  UpdateAppointment({this.appointment});

  @override
  List<Object> get props => [appointment];
}
