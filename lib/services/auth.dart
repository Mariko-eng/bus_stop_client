import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Client _userFromFirebaseUser(User user) {
    return user != null ? Client(uid: user.uid) : null;
  }

  Stream<Client> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  // Register with email and password
  Future registerClient(String email, String password, String phoneNumber,
      String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      Firestore firestore = Firestore(uid: user.uid);
      await firestore.createProfile(email, phoneNumber, username);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInClient(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
