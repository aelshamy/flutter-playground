import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:uuid/uuid.dart';

class StorageRepo {
  final StorageReference _storage;
  final FirestoreRepo _fireStoreRepo;

  String _postId = Uuid().v4();

  StorageRepo({StorageReference storage, FirestoreRepo fireStoreRepo})
      : _storage = storage ?? FirebaseStorage.instance.ref(),
        _fireStoreRepo = fireStoreRepo ?? FirestoreRepo();

  Future<void> uploadAssetToStorage({File image, String description, String location, User user}) async {
    File compressedImageFile = await _compressImage(image);
    final String mediaUrl = await _uploadImage(compressedImageFile);
    await _fireStoreRepo.createPost(id: _postId, mediaUrl: mediaUrl, description: description, location: location, user: user);
    _postId = Uuid().v4();
  }

  Future<File> _compressImage(File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image imageFile = im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/image_${_postId}.jpg')..writeAsBytesSync(im.encodeJpg(imageFile, quality: 85));
    return compressedImageFile;
  }

  Future<String> _uploadImage(File file) async {
    final StorageUploadTask uploadTask = _storage.child("post_$_postId.jpg").putFile(file);
    final StorageTaskSnapshot uploadSnapshot = await uploadTask.onComplete;
    final String downloadUrl = await uploadSnapshot.ref.getDownloadURL() as String;
    return downloadUrl;
  }
}
