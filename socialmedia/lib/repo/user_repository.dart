import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final CollectionReference postRef = Firestore.instance.collection('posts');
final CollectionReference commentsRef = Firestore.instance.collection('comments');
const usersCollection = 'users';
// User currentUser;

class UserRepository {
  final Firestore _firestoreInstance;
  final GoogleSignIn _googleSignIn;

  UserRepository({Firestore firebaseAuth, GoogleSignIn googleSignin})
      : _firestoreInstance = firebaseAuth ?? Firestore.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    return await _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> signInSilentlyWithGoogle() async {
    return await _googleSignIn.signInSilently(suppressErrors: false);
  }

  Future<void> createUser(String username) async {
    final user = _googleSignIn.currentUser;

    final Map<String, String> data = {
      "id": user.id,
      "username": username,
      "photoUrl": user.photoUrl,
      "email": user.email,
      "displayName": user.displayName,
      "bio": "",
      "timestamp": DateTime.now() as String
    };
    return _firestoreInstance.collection(usersCollection).document(user.id).setData(data);
  }

  Future<bool> isSignedIn() async {
    return _googleSignIn.currentUser != null;
  }

  Future<DocumentSnapshot> getUser() async {
    final GoogleSignInAccount user = _googleSignIn.currentUser;
    return await _firestoreInstance.collection(usersCollection).document(user.id).get();
  }

  Future<GoogleSignInAccount> signOut() async {
    return _googleSignIn.signOut();
  }

  Future<QuerySnapshot> SearchUsers(String query) async {
    final doc = await _firestoreInstance.collection(usersCollection).where("displayName", isGreaterThanOrEqualTo: query).getDocuments();
    return doc;
  }
}
