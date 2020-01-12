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
        id: document["id"],
        username: document["username"],
        photoUrl: document["photoUrl"],
        email: document["email"],
        displayName: document["displayName"],
        bio: document["bio"],
      );

  Map<String, dynamic> toDocument() => {
        "id": this.id,
        "username": this.username,
        "photoUrl": this.photoUrl,
        "email": this.email,
        "displayName": this.displayName,
        "bio": this.bio,
        "timestamp": DateTime.now()
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
