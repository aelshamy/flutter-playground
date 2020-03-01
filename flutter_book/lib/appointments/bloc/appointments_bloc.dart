import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/repo/appointments_repo.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepo _appointmentsRepo;

  AppointmentsBloc({AppointmentsRepo appointmentsRepo})
      : _appointmentsRepo = appointmentsRepo ?? AppointmentsRepo();

  @override
  AppointmentsState get initialState => AppointmentsInitial();

  @override
  Stream<AppointmentsState> mapEventToState(
    AppointmentsEvent event,
  ) async* {
    if (event is LoadAppointments) {
      yield* _mapLoadAppointmentsToState();
    }

    if (event is AddAppointment) {
      yield* _mapAddAppointmentToState(event.appointment);
    }
    if (event is UpdateAppointment) {
      yield* _mapUpdateAddAppointmentToState(event.appointment);
    }
    if (event is DeleteAppointment) {
      yield* _mapDeleteAddAppointmentToState(event.appointmentId);
    }
  }

  Stream<AppointmentsState> _mapLoadAppointmentsToState() async* {
    final appointments = await _appointmentsRepo.getAll();
    yield AppointmentsLoaded(appointments: appointments);
  }

  Stream<AppointmentsState> _mapAddAppointmentToState(Appointment appointment) async* {
    await _appointmentsRepo.addAppointment(appointment);
    final appointments = await _appointmentsRepo.getAll();
    yield AppointmentsLoaded(appointments: appointments);
  }

  Stream<AppointmentsState> _mapUpdateAddAppointmentToState(Appointment appointment) async* {
    await _appointmentsRepo.updateAppointment(appointment);
    final appointments = await _appointmentsRepo.getAll();
    yield AppointmentsLoaded(appointments: appointments);
  }

  Stream<AppointmentsState> _mapDeleteAddAppointmentToState(int appointmentId) async* {
    await _appointmentsRepo.deleteAppointment(appointmentId);
    final appointments = await _appointmentsRepo.getAll();
    yield AppointmentsLoaded(appointments: appointments);
  }
}
