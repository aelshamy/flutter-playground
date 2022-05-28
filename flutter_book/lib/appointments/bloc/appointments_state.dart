part of 'appointments_bloc.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();
}

class AppointmentsInitial extends AppointmentsState {
  @override
  List<Object> get props => [];
}

class AppointmentsLoaded extends AppointmentsState {
  final List<Appointment> appointments;

  const AppointmentsLoaded({required this.appointments});

  @override
  List<Object> get props => [appointments];
}
