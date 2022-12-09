import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SpotifyNotesFirebaseUser {
  SpotifyNotesFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

SpotifyNotesFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SpotifyNotesFirebaseUser> spotifyNotesFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SpotifyNotesFirebaseUser>(
      (user) {
        currentUser = SpotifyNotesFirebaseUser(user);
        return currentUser!;
      },
    );
