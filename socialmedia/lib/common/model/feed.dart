import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum FeedType { like, comment, follow }

class Feed extends Equatable {
  final FeedType type;
  final String commentData;
  final String username;
  final String userId;
  final String userProfileImage;
  final String postId;
  final String mediaUrl;
  final dynamic postLikes;
  final String postDescription;
  final String postLocation;
  final Timestamp timestamp;

  const Feed({
    this.type,
    this.commentData,
    this.username,
    this.userId,
    this.userProfileImage,
    this.postId,
    this.mediaUrl,
    this.postLikes,
    this.postDescription,
    this.postLocation,
    this.timestamp,
  });

  factory Feed.fromDocument(DocumentSnapshot doc) => Feed(
        type: FeedType.values.firstWhere((e) => e.toString() == doc["type"]),
        commentData: doc["commentData"].toString(),
        username: doc["username"].toString(),
        userId: doc["userId"].toString(),
        userProfileImage: doc["userProfileImage"].toString(),
        postId: doc["postId"].toString(),
        mediaUrl: doc["mediaUrl"].toString(),
        postLikes: doc["postLikes"],
        postDescription: doc["postDescription"].toString(),
        postLocation: doc["postLocation"].toString(),
        timestamp: doc["timestamp"] as Timestamp,
      );

  @override
  List<Object> get props => [
        type,
        commentData,
        username,
        userId,
        userProfileImage,
        postId,
        mediaUrl,
        postLikes,
        postDescription,
        postLocation,
        timestamp
      ];
}
