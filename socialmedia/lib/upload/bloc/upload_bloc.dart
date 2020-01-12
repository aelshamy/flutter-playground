import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  @override
  UploadState get initialState => InitialUploadState();

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
