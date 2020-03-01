import 'package:flutter_book/contacts/contact.dart';
import 'package:flutter_book/contacts/repo/contacts_provider.dart';

class ContactsRepo {
  final ContactsProvider _contactsProvider;
  ContactsRepo({ContactsProvider contactsProvider})
      : _contactsProvider = contactsProvider ?? ContactsProvider();

  Future<List<Contact>> getAll() {
    return _contactsProvider.getAll();
  }

  Future<int> addContact(Contact contact) {
    return _contactsProvider.create(contact);
  }

  Future<int> updateContact(Contact contact) {
    return _contactsProvider.update(contact);
  }

  Future<int> deleteContact(int contactId) {
    return _contactsProvider.delete(contactId);
  }
}
