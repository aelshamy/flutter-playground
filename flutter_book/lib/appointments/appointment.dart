import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final int id;
  final String title;
  final String description;
  final String appointmentDate;
  final String appointmentTime;

  const Appointment({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.appointmentDate = "",
    this.appointmentTime = "",
  });

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
  String toString() {
    return "{ id=$id, title=$title, description=$description, appointmentDate=$appointmentDate, appointmentTime=$appointmentTime }";
  }

  @override
  List<Object> get props =>
      [id, title, description, appointmentDate, appointmentTime];

  Appointment copyWith({
    int? id,
    String? title,
    String? description,
    String? appointmentDate,
    String? appointmentTime,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
    );
  }
}
