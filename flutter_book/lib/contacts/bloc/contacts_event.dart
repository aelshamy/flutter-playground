part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();
}

class LoadContacts extends ContactsEvent {
  @override
  List<Object> get props => [];
}

class DeleteContact extends ContactsEvent {
  final int contactId;

  const DeleteContact({required this.contactId});

  @override
  List<Object> get props => [contactId];
}

class AddContact extends ContactsEvent {
  final Contact contact;

  const AddContact({required this.contact});

  @override
  List<Object> get props => [contact];
}

class UpdateContact extends ContactsEvent {
  final Contact contact;

  const UpdateContact({required this.contact});

  @override
  List<Object> get props => [contact];
}
