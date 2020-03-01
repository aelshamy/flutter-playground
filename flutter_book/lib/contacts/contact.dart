import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String birthday;

  Contact({this.id, this.name, this.phone, this.email, this.birthday});

  factory Contact.fromMap(Map inMap) => Contact(
        id: inMap["id"],
        name: inMap["name"],
        phone: inMap["phone"],
        email: inMap["email"],
        birthday: inMap["birthday"],
      );

  Map<String, dynamic> toMap(Contact contact) {
    return {
      "id": contact.id,
      "name": contact.name,
      "phone": contact.phone,
      "email": contact.email,
      "birthday": contact.birthday,
    };
  }

  Contact copyWith({
    int id,
    String name,
    String phone,
    String email,
    String birthday,
  }) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
      );

  @override
  String toString() {
    return "{ id=$id, name=$name, phone=$phone, email=$email, birthday=$birthday }";
  }

  @override
  List<Object> get props => [id, name, phone, email, birthday];
}
