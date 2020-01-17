import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String photoUrl;
  final String email;
  final String displayName;
  final String bio;

  User({
    this.id,
    this.username,
    this.photoUrl,
    this.email,
    this.displayName,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot document) => User(
        id: document["id"] as String,
        username: document["username"] as String,
        photoUrl: document["photoUrl"] as String,
        email: document["email"] as String,
        displayName: document["displayName"] as String,
        bio: document["bio"] as String,
      );

  Map<String, String> toDocument() => {
        "id": this.id,
        "username": this.username,
        "photoUrl": this.photoUrl,
        "email": this.email,
        "displayName": this.displayName,
        "bio": this.bio,
        "timestamp": DateTime.now() as String
      };

  @override
  String toString() {
    return '''User {
      id: $id,
      username: $username,
      photoUrl: $photoUrl,
      email: $email,
      displayName: $displayName,
      bio: $bio,
    }''';
  }
}
