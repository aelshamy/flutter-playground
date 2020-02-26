import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:socialmedia/repo/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final FirestoreRepo firestoreRepo;

  StreamSubscription _userSubscription;

  UserBloc({@required this.userRepository, @required this.firestoreRepo})
      : assert(userRepository != null, firestoreRepo != null);

  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
    } else if (event is CreateUser) {
      yield UserDoesNotExists();
    } else if (event is CreateUsername) {
      yield* _mapCreateuserToState(event.username);
    } else if (event is LoginUser) {
      yield UserAuthenticated(user: event.user);
    } else if (event is LogoutUser) {
      yield* _mapLoggedOutToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event.userId, event.displayName, event.bio);
    }
  }

  Stream<UserState> _mapAppStartedToState() async* {
    try {
      await userRepository.signInSilentlyWithGoogle();
      _userSubscription?.cancel();
      _userSubscription = userRepository.getUser().listen((doc) {
        if (!doc.exists) {
          add(CreateUser());
        } else {
          add(LoginUser(user: User.fromDocument(doc)));
        }
      });
    } catch (_) {
      yield UserNotAuthenticated();
    }
  }

  Stream<UserState> _mapLoginWithGoogleToState() async* {
    yield UserLoadding();
    try {
      await userRepository.signInWithGoogle();
      _userSubscription?.cancel();
      _userSubscription = userRepository.getUser().listen((doc) {
        if (!doc.exists) {
          add(CreateUser());
        } else {
          add(LoginUser(user: User.fromDocument(doc)));
        }
      });
    } catch (e) {
      yield UserError(error: e.toString());
    }
  }

  Stream<UserState> _mapCreateuserToState(String username) async* {
    try {
      final User user = await userRepository.createUser(username);
      yield UserAuthenticated(user: user);
    } catch (e) {
      yield UserError(error: e.toString());
    }
  }

  Stream<UserState> _mapLoggedOutToState() async* {
    try {
      await userRepository.signOut();
      yield UserNotAuthenticated();
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<UserState> _mapUpdateUserToState(String userId, String displayName, String bio) async* {
    await firestoreRepo.updateUser(userId, displayName, bio);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
