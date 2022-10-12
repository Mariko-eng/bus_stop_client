import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip {
  final String id;
  final DocumentReference arrivalLocation;
  final DocumentReference departureLocation;
  final DocumentReference company;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int totalSeats;
  final int occupiedSeats;
  final int price;
  final int totalOrdinarySeats;
  final int occupiedOrdinarySeats;
  final int priceOrdinary;
  final int totalVipSeats;
  final int occupiedVipSeats;
  final int priceVip;
  final String tripNumber;
  final String tripType;
  Map<String, dynamic> companyData;
  Map<String, dynamic> arrival;
  Map<String, dynamic> departure;

  Trip({
    this.id,
    this.arrivalLocation,
    this.departureLocation,
    this.company,
    this.departureTime,
    this.arrivalTime,
    this.totalSeats,
    this.occupiedSeats,
    this.price,
    this.totalOrdinarySeats,
    this.occupiedOrdinarySeats,
    this.priceOrdinary,
    this.totalVipSeats,
    this.occupiedVipSeats,
    this.priceVip,
    this.tripNumber,
    this.tripType
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
        departureTime: data['departureTime'].toDate(),
        arrivalTime: data['arrivalTime'].toDate(),
        totalSeats: data['totalSeats'],
        occupiedSeats: data['occupiedSeats'],
        price: data['price'],
        totalOrdinarySeats: data['totalOrdinarySeats'],
        occupiedOrdinarySeats: data['occupiedOrdinarySeats'],
        priceOrdinary: data['priceOrdinary'],
        totalVipSeats: data['totalVipSeats'],
        occupiedVipSeats: data['occupiedVipSeats'],
        priceVip: data['priceVip'],
        tripNumber: data['tripNumber'] ?? "",
        tripType: data['tripType'] ?? ""
    );
  }
}

Stream<List<Trip>> getAllTripsForBusCompany({String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return FirebaseFirestore.instance.collection('trips')
      .where('companyId', isEqualTo: companyId)
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      // .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs
        .map((doc) => Trip.fromSnapshot(doc))
        .toList();
  });
}
