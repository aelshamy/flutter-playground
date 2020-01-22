import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class UploadInitial extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadPhotoSelected extends UploadState {
  final File image;

  const UploadPhotoSelected({this.image});

  @override
  List<Object> get props => [image];
}
