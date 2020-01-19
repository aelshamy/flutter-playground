import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/common/model/user.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent([List props = const <dynamic>[]]);
}

class SelectPhoto extends UploadEvent {
  final ImageSource source;

  SelectPhoto({this.source}) : super(<dynamic>[source]);
  @override
  String toString() {
    return "Uploading photo";
  }

  @override
  List<Object> get props => null;
}

class CreatePost extends UploadEvent {
  final File image;
  final String description;
  final String location;
  final User user;

  CreatePost({this.image, this.user, this.description, this.location}) : super(<dynamic>[image, user, description, location]);

  @override
  String toString() {
    return "Create Post";
  }

  @override
  List<Object> get props => null;
}

class CancelUpload extends UploadEvent {
  @override
  String toString() {
    return "Cancel upload...";
  }

  @override
  List<Object> get props => null;
}
