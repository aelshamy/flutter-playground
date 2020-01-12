import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final CollectionReference postRef = Firestore.instance.collection('posts');
final CollectionReference commentsRef = Firestore.instance.collection('comments');
const usersCollection = 'users';
// User currentUser;

class UserRepository {
  final Firestore _firestoreInstance;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firestoreInstance = firebaseAuth ?? Firestore.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    return await _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> signInSilentlyWithGoogle() async {
    return _googleSignIn.signInSilently(suppressErrors: false);
  }

  Future<void> createUser(username) async {
    final user = _googleSignIn.currentUser;

    return _firestoreInstance.collection(usersCollection).document(user.id).setData({
      "id": user.id,
      "username": username,
      "photoUrl": user.photoUrl,
      "email": user.email,
      "displayName": user.displayName,
      "bio": "",
      "timestamp": DateTime.now()
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = _googleSignIn.currentUser;
    return currentUser != null;
  }

  Future<DocumentSnapshot> getUser() async {
    final GoogleSignInAccount user = _googleSignIn.currentUser;
    DocumentSnapshot doc =
        await _firestoreInstance.collection(usersCollection).document(user.id).get();
    return doc;
  }

  Future<GoogleSignInAccount> signOut() async {
    return _googleSignIn.signOut();
  }
}
