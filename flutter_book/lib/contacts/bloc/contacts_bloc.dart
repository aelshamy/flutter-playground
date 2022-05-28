import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/contacts/contact.dart';
import 'package:flutter_book/contacts/repo/contacts_repo.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepo _contactsRepo;

  ContactsBloc({ContactsRepo? contactsRepo})
      : _contactsRepo = contactsRepo ?? ContactsRepo(),
        super(ContactsInitial()) {
    on<LoadContacts>((event, emit) async {
      final contacts = await _contactsRepo.getAll();
      emit(ContactsLoaded(contacts: contacts));
    });

    on<AddContact>((event, emit) async {
      await _contactsRepo.addContact(event.contact);
      final contacts = await _contactsRepo.getAll();
      emit(ContactsLoaded(contacts: contacts));
    });

    on<UpdateContact>((event, emit) async {
      await _contactsRepo.updateContact(event.contact);
      final contacts = await _contactsRepo.getAll();
      emit(ContactsLoaded(contacts: contacts));
    });

    on<DeleteContact>((event, emit) async {
      await _contactsRepo.deleteContact(event.contactId);
      final contacts = await _contactsRepo.getAll();
      emit(ContactsLoaded(contacts: contacts));
    });
  }
}
