import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String owner;
  final String username;
  final String mediaUrl;
  final String description;
  final String location;
  final dynamic likes;

  Post({
    this.postId,
    this.owner,
    this.username,
    this.mediaUrl,
    this.description,
    this.location,
    this.likes,
  });

  factory Post.fromDocument(DocumentSnapshot doc) => Post(
        postId: doc["postId"] as String,
        owner: doc["owner"] as String,
        username: doc["username"] as String,
        mediaUrl: doc["mediaUrl"] as String,
        description: doc["description"] as String,
        location: doc["location"] as String,
        likes: doc["likes"],
      );
}
