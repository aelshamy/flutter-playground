import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';

class FirestoreRepo {
  final Firestore _firestoreInstance;

  FirestoreRepo({Firestore firebaseAuth}) : _firestoreInstance = firebaseAuth ?? Firestore.instance;

  Future<void> createUser(GoogleSignInAccount user, String username) async {
    final Map<String, dynamic> data = {
      "id": user.id,
      "username": username,
      "photoUrl": user.photoUrl,
      "email": user.email,
      "displayName": user.displayName,
      "bio": "",
      "timestamp": DateTime.now()
    };
    return await _firestoreInstance.collection('users').document(user.id).setData(data);
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await _firestoreInstance.collection('users').document(userId).get();
  }

  Future<QuerySnapshot> searchUsers(String query) async {
    return await _firestoreInstance.collection('users').where("displayName", isGreaterThanOrEqualTo: query).getDocuments();
  }

  Future<void> updateUser(String userId, String displayName, String bio) async {
    return await _firestoreInstance.collection('users').document(userId).updateData({
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
    return await _firestoreInstance.collection('posts').document(user.id).collection("userPosts").document(id).setData(data);
  }

  Future<QuerySnapshot> getUserPosts(String userId) async {
    return await _firestoreInstance
        .collection('posts')
        .document(userId)
        .collection("userPosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();
  }

  Future<void> likePost(Post post, User user) async {
    bool isliked = post.likes[user?.id] == true;
    post.likes[user?.id] = !isliked;

    try {
      return await _firestoreInstance
          .collection('posts')
          .document(post.owner)
          .collection("userPosts")
          .document(post.postId)
          .updateData({"likes.${user.id}": !isliked});
    } catch (e) {
      print(e);
    }
  }
}
