import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState([List _props = const <dynamic>[]]);
}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}
