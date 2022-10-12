import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      print("Here");
      // _client = Client(uid: user.uid);
      _client = await getProfile(uid: user.uid);
      if (_client == null) {
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
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
      _client = await getProfile(uid: user.uid);
      if (_client == null) {
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
      // _client = Client(uid: user.uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Failed To Login", "Try Again");
    }
  }

  Future registerClient(
      {String email,
      String password,
      String phoneNumber,
      String username}) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      await createProfile(
          uid: user.uid,
          email: email,
          phoneNumber: phoneNumber,
          username: username);
      _client = Client(
          uid: user.uid,
          username: username,
          email: email,
          phoneNumber: phoneNumber);
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

  Future<Client> getProfile({String uid}) async {
    Client currentClient;
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection("clients").doc(uid).get();
      currentClient = Client.fromSnapshot(snap);
      return currentClient;
    } catch (e) {
      print(e.toString());
      return currentClient;
    }
  }

  Future signOut() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _isLoading = false;
    notifyListeners();
  }

  Future deleteUserAccount({String email, String password}) async{
    FirebaseApp myApp = await Firebase.initializeApp(
        name: 'ticket', options: Firebase.app().options);
    FirebaseAuth autApp = FirebaseAuth.instanceFor(app: myApp);
    try{
      _isLoading = true;
      notifyListeners();
      // await _auth.signOut();
      UserCredential result = await autApp.signInWithEmailAndPassword(email: email, password: password);
      await result.user.delete();
      await myApp.delete();
      await _auth.signOut();
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Account Deleted Successfully", "Come Again",
          backgroundColor: Colors.green,
          colorText: Colors.white
      );
    }catch(e){
      String err = e.toString();
      print(err);
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Failed to Delete Account", "Come Again",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

}
