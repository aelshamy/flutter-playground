import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/pages/home.dart';

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
        postId: doc["postId"],
        owner: doc["owner"],
        username: doc["username"],
        mediaUrl: doc["mediaUrl"],
        description: doc["description"],
        location: doc["location"],
        likes: doc["likes"],
      );

  int getLikeCount() {
    if (likes == null) return 0;
    return likes.values.takeWhile((item) => item == true).length;
  }

  bool isLikedByCurrentUser() {
    return likes[currentUser?.id] == true;
  }

  likePost() {
    bool isliked = likes[currentUser.id] == true;

    likes[currentUser?.id] = !isliked;
    postRef
        .document(owner)
        .collection('userPosts')
        .document(postId)
        .updateData({"likes.${currentUser.id}": !isliked});
  }
}