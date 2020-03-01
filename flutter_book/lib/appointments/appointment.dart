import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final int id;
  final String title;
  final String description;
  final String appointmentDate;
  final String appointmentTime;

  Appointment({this.id, this.title, this.description, this.appointmentDate, this.appointmentTime});

  factory Appointment.fromMap(Map inMap) => Appointment(
        id: inMap["id"],
        title: inMap["title"],
        description: inMap["description"],
        appointmentDate: inMap["appointmentDate"],
        appointmentTime: inMap["appointmentTime"],
      );

  Map<String, dynamic> toMap(Appointment appointment) {
    return {
      "id": appointment.id,
      "title": appointment.title,
      "description": appointment.description,
      "appointmentDate": appointment.appointmentDate,
      "appointmentTime": appointment.appointmentTime,
    };
  }

  @override
  List<Object> get props => [id, title, description, appointmentDate, appointmentTime];
}
