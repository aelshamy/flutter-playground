import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/common/model/comment.dart';
import 'package:socialmedia/common/model/notification.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';

class FirestoreRepo {
  final Firestore _firestoreInstance;

  FirestoreRepo({Firestore firebaseAuth}) : _firestoreInstance = firebaseAuth ?? Firestore.instance;

  Future<User> createUser(GoogleSignInAccount user, String username) async {
    final User newUser = User(
      id: user.id,
      username: username,
      photoUrl: user.photoUrl,
      email: user.email,
      displayName: user.displayName,
      bio: "",
    );

    _firestoreInstance.collection('users').document(user.id).setData(newUser.toDocument());

    return newUser;
  }

  Stream<DocumentSnapshot> getUser(String userId) {
    return _firestoreInstance.collection('users').document(userId).snapshots();
  }

  Future<QuerySnapshot> searchUsers(String query) async {
    return _firestoreInstance
        .collection('users')
        .where("displayName", isGreaterThanOrEqualTo: query)
        .getDocuments();
  }

  Future<void> updateUser(String userId, String displayName, String bio) async {
    return _firestoreInstance.collection('users').document(userId).updateData({
      "displayName": displayName,
      "bio": bio,
    });
  }

  Future<void> createPost(
      {String id, String mediaUrl, String location, String description, User user}) async {
    final Map<String, dynamic> data = {
      "postId": id,
      "owner": user.id,
      "username": user.username,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": DateTime.now(),
      "likes": {},
    };
    return _firestoreInstance
        .collection('posts')
        .document(user.id)
        .collection("userPosts")
        .document(id)
        .setData(data);
  }

  Stream<List<Post>> getUserPosts(String userId) {
    return _firestoreInstance
        .collection('posts')
        .document(userId)
        .collection("userPosts")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Future<void> likePost(Post post, User user) async {
    final bool isliked = post.likes[user?.id] == true;
    post.likes[user?.id] = !isliked;

    try {
      return await _firestoreInstance
          .collection('posts')
          .document(post.owner)
          .collection("userPosts")
          .document(post.postId)
          .updateData({"likes.${user.id}": !isliked});
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Comment>> getPostComments(String postId) {
    return _firestoreInstance
        .collection('comments')
        .document(postId)
        .collection('comments')
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => Comment.fromDocument(doc)).toList();
    });
  }

  Future<void> addComment(Post post, User user, String comment) async {
    try {
      return await _firestoreInstance
          .collection('comments')
          .document(post.postId)
          .collection("comments")
          .add({
        "username": user.username,
        "userId": user.id,
        "avatarUrl": user.photoUrl,
        "comment": comment,
        "timestamp": DateTime.now()
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addLikesToFeed(Post post, User currentUser) async {
    try {
      return await _firestoreInstance
          .collection('feed')
          .document(post.owner)
          .collection("posts")
          .document(post.postId)
          .collection("feedItems")
          .document()
          .setData({
        "type": NotificationType.like.toString(),
        "username": currentUser.username,
        "userId": currentUser.id,
        "userProfileImage": currentUser.photoUrl,
        "postId": post.postId,
        "mediaUrl": post.mediaUrl,
        "postLikes": post.likes,
        "postDescription": post.description,
        "postLocation": post.location,
        "timestamp": DateTime.now(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeLikesToFeed(Post post, User currentUser) async {
    try {
      return await _firestoreInstance
          .collection('feed')
          .document(post.owner)
          .collection("posts")
          .document(post.postId)
          .collection("feedItems")
          .where("userId", isEqualTo: currentUser.id)
          .where("type", isEqualTo: "FeedType.like")
          .limit(1)
          .getDocuments()
          .then((snapshot) {
        final doc = snapshot.documents.first;
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addCommentToFeed(Post post, User currentUser, String comment) async {
    try {
      return await _firestoreInstance
          .collection('feed')
          .document(post.owner)
          .collection("posts")
          .document(post.postId)
          .collection("feedItems")
          .document()
          .setData({
        "type": NotificationType.comment.toString(),
        "commentData": comment,
        "username": currentUser.username,
        "userId": currentUser.id,
        "userProfileImage": currentUser.photoUrl,
        "postId": post.postId,
        "mediaUrl": post.mediaUrl,
        "postLikes": post.likes,
        "postDescription": post.description,
        "postLocation": post.location,
        "timestamp": DateTime.now(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Notification>> getFeed(String userId) {
    // _firestoreInstance
    //     .collection('feed')
    //     .document(userId)
    //     .collection("posts")
    //     .getDocuments()
    //     .then((doc) {
    //   print(doc.documents);
    // });
    return _firestoreInstance
        .collection('feed')
        .document(userId)
        .collection("posts")
        .document("62e6aa87-b90b-453f-953a-e85f26c7d635")
        .collection("feedItems")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => Notification.fromDocument(doc)).toList();
    });
  }
}
