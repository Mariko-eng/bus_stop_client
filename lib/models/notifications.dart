import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications{
  String id;
  String clientId;
  String busCompanyId;
  String title;
  String body;
  bool isClientBased;
  DateTime dateCreated;

  Notifications({
    this.id,
    this.clientId,
    this.busCompanyId,
    this.title,
    this.body,
    this.isClientBased,
    this.dateCreated
  });

  factory Notifications.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data();
    return Notifications(
      id: snapshot.id,
      clientId: data["clientId"],
      busCompanyId: data["busCompanyId"],
      title: data["title"],
      body: data["body"],
      isClientBased: data["isClientBased"],
      dateCreated: data["dateCreated"].toDate(),
    );
  }
}

Future<bool> addClientNotification({
  String clientId,
  String busCompanyId,
  String title,
  String body,
}) async{
  DateTime nw = DateTime.now();
  try{
    await FirebaseFirestore.instance.collection("notifications").add({
      "clientId":clientId,
      "busCompanyId":busCompanyId,
      "title":title,
      "body":body,
      "isClientBased": true,
      "dateCreated": nw
    });
    return true;
  }catch(e){
    return false;
  }
}


