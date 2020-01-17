import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comment({
    this.username,
    this.userId,
    this.avatarUrl,
    this.comment,
    this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) => Comment(
        username: doc['username'] as String,
        userId: doc['userId'] as String,
        avatarUrl: doc['avatarUrl'] as String,
        comment: doc['comment'] as String,
        timestamp: doc['timestamp'] as Timestamp,
      );
}
