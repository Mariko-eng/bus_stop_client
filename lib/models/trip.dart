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
}
