import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/common/model/comment.dart';
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
    return _firestoreInstance.collection('users').where("displayName", isGreaterThanOrEqualTo: query).getDocuments();
  }

  Future<void> updateUser(String userId, String displayName, String bio) async {
    return _firestoreInstance.collection('users').document(userId).updateData({
      "displayName": displayName,
      "bio": bio,
    });
  }

  Future<void> createPost({String id, String mediaUrl, String location, String description, User user}) async {
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
    return _firestoreInstance.collection('posts').document(user.id).collection("userPosts").document(id).setData(data);
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

  Future<void> addComment(String postId, User user, String comment) async {
    try {
      return await _firestoreInstance
          .collection('comments')
          .document(postId)
          .collection("comments")
          .add({"username": user.username, "userId": user.id, "avatarUrl": user.photoUrl, "comment": comment, "timestamp": DateTime.now()});
    } catch (e) {
      log(e.toString());
    }
  }
}
