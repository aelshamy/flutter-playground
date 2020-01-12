import 'package:firebase_storage/firebase_storage.dart';

class Firestore {
  final StorageReference db = FirebaseStorage.instance.ref();
}

Firestore storage = Firestore();
