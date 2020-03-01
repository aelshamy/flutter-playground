import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/contacts/contact.dart';
import 'package:flutter_book/contacts/repo/contacts_repo.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepo _contactsRepo;

  ContactsBloc({ContactsRepo contactsRepo}) : _contactsRepo = contactsRepo ?? ContactsRepo();

  @override
  ContactsState get initialState => ContactsInitial();

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    if (event is LoadContacts) {
      yield* _mapLoadContactsToState();
    } else if (event is AddContact) {
      yield* _mapAddContactToState(event.contact);
    } else if (event is UpdateContact) {
      yield* _mapUpdateContactToState(event.contact);
    } else if (event is DeleteContact) {
      yield* _mapDeleteContactToState(event.contactId);
    }
  }

  Stream<ContactsState> _mapLoadContactsToState() async* {
    final contacts = await _contactsRepo.getAll();
    yield ContactsLoaded(contacts: contacts);
  }

  Stream<ContactsState> _mapAddContactToState(Contact contact) async* {
    await _contactsRepo.addContact(contact);
    final contacts = await _contactsRepo.getAll();
    yield ContactsLoaded(contacts: contacts);
  }

  Stream<ContactsState> _mapUpdateContactToState(Contact contact) async* {
    await _contactsRepo.updateContact(contact);
    final contacts = await _contactsRepo.getAll();
    yield ContactsLoaded(contacts: contacts);
  }

  Stream<ContactsState> _mapDeleteContactToState(int contactId) async* {
    await _contactsRepo.deleteContact(contactId);
    final contacts = await _contactsRepo.getAll();
    yield ContactsLoaded(contacts: contacts);
  }
}
