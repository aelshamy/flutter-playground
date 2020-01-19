import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/model/user.dart';

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

  Future<QuerySnapshot> SearchUsers(String query) async {
    final doc = await _firestoreInstance.collection('users').where("displayName", isGreaterThanOrEqualTo: query).getDocuments();
    return doc;
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
}
