import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Client _client;
  bool _isLoading = false;
  Client get client => _client;
  bool get isLoading => _isLoading;

  UserProvider() {
    _fireSetUp();
  }

  _fireSetUp() {
    _isLoading = true;
    notifyListeners();
    _auth.authStateChanges().listen(_onStateChanged);
  }

  _onStateChanged(User user) async {
    if (user == null) {
      _client = null;
      _isLoading = false;
      notifyListeners();
    } else {
      _client = Client(uid: user.uid);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = credential.user;
      _client = Client(uid: user.uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Failed To Login", "Try Again");
    }
  }

  Future registerClient(String email, String password, String phoneNumber,
      String username) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      await createProfile(
          uid: user.uid, email: email, phoneNumber: phoneNumber);
      _client = Client(uid: user.uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _isLoading = true;
      notifyListeners();
      Get.snackbar("Failed To Create Account", "Try Again");
    }
  }

  Future createProfile(
      {String uid, String email, String phoneNumber, String username}) async {
    return FirebaseFirestore.instance.collection("clients").doc(uid).set(
        {'email': email, 'phoneNumber': phoneNumber, 'username': username});
  }

  Future signOut() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _isLoading = false;
    notifyListeners();
  }
}
