import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip {
  final DocumentReference arrivalLocation;
  final DocumentReference departureLocation;
  final DocumentReference company;
  final DateTime depatureTime;
  final DateTime eta;
  final String id;
  final int occupiedSeats;
  final int price;
  final int totalSeats;
  final String tripNumber;
  final String ticketType;
  Map<String, dynamic> companyData;
  Map<String, dynamic> arrival;
  Map<String, dynamic> departure;

  Trip({
    this.arrivalLocation,
    this.departureLocation,
    this.company,
    this.depatureTime,
    this.eta,
    this.id,
    this.occupiedSeats,
    this.price,
    this.totalSeats,
    this.tripNumber,
    this.ticketType
  });

  Future<Trip> setCompanyData(BuildContext context) async {
    DocumentSnapshot companySnapshot = await company.get();
    companyData = {'id': companySnapshot.id}..addAll(companySnapshot.data());

    DocumentSnapshot arrivalSnapshot = await arrivalLocation.get();
    arrival = {'id': arrivalSnapshot.id}..addAll(arrivalSnapshot.data());

    DocumentSnapshot departureSnapshot = await departureLocation.get();
    departure = {'id': departureSnapshot.id}..addAll(departureSnapshot.data());

    return this;
  }

  Map<String, dynamic> getCompanyData() {
    return companyData;
  }

  factory Trip.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data();
    return Trip(
        id: snapshot.id,
        arrivalLocation: data['arrivalLocation'],
        departureLocation: data['departureLocation'],
        company: data['company'],
        eta: data['eta'].toDate(),
        depatureTime: data['depatureTime'].toDate(),
        price: data['price'],
        occupiedSeats: data['occupiedSeats'],
        totalSeats: data['totalSeats'],
        tripNumber: data['tripNumber'] ?? "",
        ticketType: data['ticketType'] ?? ""
    );
  }
}

Stream<List<Trip>> getAllTripsForBusCompany({String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return FirebaseFirestore.instance.collection('trips')
      .where('companyId', isEqualTo: companyId)
      .where('depatureTime', isGreaterThanOrEqualTo: yesterday)
      // .orderBy('depatureTime')
      .snapshots()
      .map((snap) {
    return snap.docs
        .map((doc) => Trip.fromSnapshot(doc))
        .toList();
  });
}
