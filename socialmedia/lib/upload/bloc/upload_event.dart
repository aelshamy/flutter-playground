part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();
}

class SelectPhoto extends UploadEvent {
  final ImageSource source;

  const SelectPhoto({this.source});

  @override
  List<Object> get props => [source];
}

class CreatePost extends UploadEvent {
  final File image;
  final String description;
  final String location;
  final User user;

  const CreatePost({this.image, this.user, this.description, this.location});

  @override
  List<Object> get props => [image, description, location, user];
}

class CancelUpload extends UploadEvent {
  @override
  List<Object> get props => [];
}
