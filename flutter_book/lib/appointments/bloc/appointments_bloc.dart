import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/appointments/repo/appointments_repo.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepo _appointmentsRepo;
  AppointmentsBloc({AppointmentsRepo? appointmentsRepo})
      : _appointmentsRepo = appointmentsRepo ?? AppointmentsRepo(),
        super(AppointmentsInitial()) {
    on<LoadAppointments>((event, emit) async {
      final appointments = await _appointmentsRepo.getAll();
      emit(AppointmentsLoaded(appointments: appointments));
    });

    on<AddAppointment>((event, emit) async {
      await _appointmentsRepo.addAppointment(event.appointment);
      final appointments = await _appointmentsRepo.getAll();
      emit(AppointmentsLoaded(appointments: appointments));
    });

    on<UpdateAppointment>((event, emit) async {
      await _appointmentsRepo.updateAppointment(event.appointment);
      final appointments = await _appointmentsRepo.getAll();
      emit(AppointmentsLoaded(appointments: appointments));
    });

    on<DeleteAppointment>((event, emit) async {
      await _appointmentsRepo.deleteAppointment(event.appointmentId);
      final appointments = await _appointmentsRepo.getAll();
      emit(AppointmentsLoaded(appointments: appointments));
    });
  }
}
