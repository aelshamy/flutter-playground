import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

// final CollectionReference commentsRef = Firestore.instance.collection('comments');

class UserRepository {
  final GoogleSignIn _googleSignIn;
  final FirestoreRepo _fireStoreRepo;

  UserRepository({FirestoreRepo fireStoreRepo, GoogleSignIn googleSignin})
      : _fireStoreRepo = fireStoreRepo ?? FirestoreRepo(),
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    return _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> signInSilentlyWithGoogle() async {
    return _googleSignIn.signInSilently(suppressErrors: true);
  }

  Future<void> createUser(String username) async {
    final user = _googleSignIn.currentUser;
    return _fireStoreRepo.createUser(user, username);
  }

  Future<bool> isSignedIn() async {
    return _googleSignIn.currentUser != null;
  }

  Future<DocumentSnapshot> getUser() async {
    final GoogleSignInAccount user = _googleSignIn.currentUser;
    return _fireStoreRepo.getUser(user.id);
  }

  Future<GoogleSignInAccount> signOut() async {
    return _googleSignIn.signOut();
  }
}
