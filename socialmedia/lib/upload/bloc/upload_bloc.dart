import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/repo/storage_repo.dart';

import './bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final StorageRepo _storageRepo;

  UploadBloc({StorageRepo storageRepo}) : _storageRepo = storageRepo ?? StorageRepo();

  @override
  UploadState get initialState => UploadInitial();

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is SelectPhoto) {
      yield* _mapSelectPhotoToState(event.source);
    }
    if (event is CreatePost) {
      yield* _mapCreatePostToState(event);
    }
    if (event is CancelUpload) {
      yield UploadInitial();
    }
  }

  Stream<UploadState> _mapSelectPhotoToState(ImageSource source) async* {
    final File image = await ImagePicker.pickImage(
      source: source,
      maxHeight: 675,
      maxWidth: 960,
    );
    yield UploadPhotoSelected(image: image);
  }

  Stream<UploadState> _mapCreatePostToState(CreatePost event) async* {
    (state as UploadPhotoSelected).isLoading = true;
    await _storageRepo.uploadAssetToStorage(image: event.image, user: event.user, description: event.description, location: event.location);
    (state as UploadPhotoSelected).isLoading = true;
    yield UploadInitial();
  }
}
