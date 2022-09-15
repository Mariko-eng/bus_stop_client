import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  Client({this.uid,this.username,this.email,this.phoneNumber});

  factory Client.fromSnapshot(DocumentSnapshot snapshot){
    return Client(
      uid: snapshot.id,
      username: snapshot.get("username"),
      email: snapshot.get("email"),
      phoneNumber: snapshot.get("phoneNumber")
    );
  }

}
