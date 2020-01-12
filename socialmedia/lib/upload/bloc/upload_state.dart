import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class InitialUploadState extends UploadState {
  @override
  List<Object> get props => [];
}
