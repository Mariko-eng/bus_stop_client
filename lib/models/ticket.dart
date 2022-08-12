import 'package:bus_stop/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripTicket {
  final String ticketId;
  final String departureLocation;
  final String arrivalLocation;
  final int numberOfTickets;
  final int total;
  final int amountPaid;
  final DocumentReference tripRef;
  Trip trip;
  Timestamp createdAt;

  TripTicket(
      {this.ticketId,
        this.departureLocation,
      this.arrivalLocation,
      this.numberOfTickets,
      this.total,
      this.amountPaid,
      this.tripRef,
        this.createdAt
      });

  Future<TripTicket> setTripData(BuildContext context) async {
    DocumentSnapshot snapshot = await tripRef.get();

    trip = Trip(
        id: snapshot.id,
        arrivalLocation: snapshot.get("'arrivalLocation'"),
      departureLocation: snapshot.get("'departureLocation'"),
      company: snapshot.get("'company'"),
      eta: snapshot.get("'eta'").toDate(),
      depatureTime: snapshot.get("'depatureTime'").toDate(),
      price: snapshot.get("'price'"),
      occupiedSeats: snapshot.get("'occupiedSeats'"),
      totalSeats: snapshot.get("'totalSeats'"),
    );

    return this;
  }
}
