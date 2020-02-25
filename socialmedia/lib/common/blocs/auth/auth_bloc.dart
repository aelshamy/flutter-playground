import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:socialmedia/repo/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  final FirestoreRepo firestoreRepo;

  StreamSubscription _userSubscription;

  AuthBloc({@required this.userRepository, @required this.firestoreRepo})
      : assert(userRepository != null, firestoreRepo != null);

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event.user);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event.userId, event.displayName, event.bio);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      await userRepository.signInSilentlyWithGoogle();
      _userSubscription?.cancel();
      _userSubscription = userRepository.getUser().listen((doc) {
        add(LoggedIn(user: User.fromDocument(doc)));
      });
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState(User user) async* {
    yield Authenticated(user: user);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    await userRepository.signOut();
    yield Unauthenticated();
  }

  Stream<AuthState> _mapUpdateUserToState(String userId, String displayName, String bio) async* {
    await firestoreRepo.updateUser(userId, displayName, bio);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
