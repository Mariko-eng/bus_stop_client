import 'package:bus_stop/models/parkLocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusCompany {
  String uid;
  String name;
  String email;
  String contactEmail;
  String phoneNumber;
  String hotLine;
  String logo;

  BusCompany(
      {this.uid,
      this.name,
      this.email,
      this.contactEmail,
      this.phoneNumber,
      this.hotLine,
      this.logo});

  factory BusCompany.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data();
    return BusCompany(
      uid: snap.id,
      name: data["name"],
      email: data["email"],
      contactEmail: data["contactEmail"],
      phoneNumber: data["phoneNumber"],
      hotLine: data["hotLine"],
      logo: data["logo"],
    );
  }
}

Stream<List<BusCompany>> getAllBusCompanies() {
  return FirebaseFirestore.instance
      .collection('companies')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => BusCompany.fromSnapshot(doc)).toList();
  });
}

Stream<List<ParkLocations>> getBusCompanyDestinations({String companyId}) {
  return FirebaseFirestore.instance
      .collection('companies')
      .doc(companyId)
      .snapshots()
      .map((snap) {
    var doc = snap.data()["parksLocations"];
    List<ParkLocations> _result = [];
    if (doc != null) {
      if (doc.length > 0) {
        doc.forEach((element) {
          _result.add(ParkLocations.fromMap(element));
        });
      }
    }
    return _result;
  });
}

Future getBusCompanyProfile({String userId}) async {
  try {
    var result = await FirebaseFirestore.instance
        .collection("companies")
        .doc(userId)
        .get();
    return BusCompany.fromSnapshot(result);
  } catch (e) {
    return null;
  }
}
