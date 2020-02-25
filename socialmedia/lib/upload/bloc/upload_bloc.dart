import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/storage_repo.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final StorageRepo storageRepo;

  UploadBloc({@required this.storageRepo}) : assert(storageRepo != null);

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
    if (image != null) {
      yield UploadPhotoSelected(image: image);
    }
  }

  Stream<UploadState> _mapCreatePostToState(CreatePost event) async* {
    await storageRepo.uploadAssetToStorage(
        image: event.image,
        user: event.user,
        description: event.description,
        location: event.location);

    yield UploadInitial();
  }
}
