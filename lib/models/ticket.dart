import 'package:bus_stop/models/notifications.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

final CollectionReference tripsCollection =
    FirebaseFirestore.instance.collection('trips');
final CollectionReference ticketsCollection =
    FirebaseFirestore.instance.collection('tickets');
final CollectionReference clientsCollection =
    FirebaseFirestore.instance.collection('clients');

class TripTicket {
  final String ticketId;
  final String departureLocation;
  final String arrivalLocation;
  final int numberOfTickets;
  final int total;
  final int amountPaid;
  final String ticketType;
  final String ticketNumber;
  final String userId;
  final String status;
  final bool success;
  final String transactionId;
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
      this.ticketType,
      this.ticketNumber,
      this.userId,
      this.status,
      this.success,
      this.transactionId,
      this.createdAt});

  Future<TripTicket> setTripData(BuildContext context) async {
    DocumentSnapshot snapshot = await tripRef.get();

    trip = Trip(
      id: snapshot.id,
      arrivalLocation: snapshot.get('arrivalLocation'),
      departureLocation: snapshot.get('departureLocation'),
      company: snapshot.get('company'),
      departureTime: snapshot.get('departureTime').toDate(),
      arrivalTime: snapshot.get('arrivalTime').toDate(),
      totalSeats: snapshot.get('totalSeats'),
      occupiedSeats: snapshot.get('occupiedSeats'),
      price: snapshot.get('price'),
      totalOrdinarySeats: snapshot.get('totalOrdinarySeats'),
      occupiedOrdinarySeats: snapshot.get('occupiedOrdinarySeats'),
      priceOrdinary: snapshot.get('priceOrdinary'),
      totalVipSeats: snapshot.get('totalVipSeats'),
      occupiedVipSeats: snapshot.get('occupiedVipSeats'),
      priceVip: snapshot.get('priceVip'),
      tripType: snapshot.get('tripType'),
    );

    return this;
  }

  factory TripTicket.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return TripTicket(
        ticketId: snapshot.id,
        departureLocation: data['departureLocation'],
        arrivalLocation: data['arrivalLocation'],
        numberOfTickets: data['numberOfTickets'],
        total: data['total'],
        amountPaid: data['amountPaid'],
        tripRef: data['trip'],
        ticketType: data['ticketType'] ?? "",
        ticketNumber: data['ticketNumber'] ?? "",
        userId: data['userId'] ?? "",
        status: data['status'] ?? "",
        success: data['success'] ?? true,
        transactionId: data['transactionId'] ?? "",
        createdAt: data['createdAt']);
  }
}

Future<String> getRandomNumber() async {
  String num = randomNumeric(6);
  try {
    var res =
        await ticketsCollection.where("ticketNumber", isEqualTo: num).get();
    if (res.docs.isEmpty) {
      return num;
    } else {
      return getRandomNumber();
    }
  } catch (e) {
    print("Error While Checking For Ticket Number");
    return num;
  }
}

Future purchaseOrdinaryTicket(
    {Client client,
    Trip trip,
    int numberOfTickets,
    int total,
    int amountPaid,
    String status,
    bool success,
    String transactionId,
    String txRef}) async {
  try {
    String num = await getRandomNumber();
    final data = {
      'companyId': trip.companyData['id'],
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocation': trip.departure['name'],
      'arrivalLocation': trip.arrival['name'],
      'numberOfTickets': numberOfTickets,
      'user': clientsCollection.doc(client.uid),
      'userId': client.uid,
      'total': total,
      'amountPaid': amountPaid,
      'ticketType':"Ordinary",
      'ticketNumber': num,
      'paymentStatus': status,
      'paymentSuccessFul': success,
      'paymentTransactionId': transactionId,
      'paymentTxRef': txRef,
      'status': "pending",
      'createdAt': DateTime.now(),
    };

    await ticketsCollection.add(data);

    await addClientNotification(
      clientId: client.uid,
      busCompanyId: trip.companyData['id'],
      title: "New Ordinary Ticket",
      body: num +" Ticket Has Been Purchased Successfully",
    );

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    return await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
  } catch (e) {
    print(e.toString());
  }
}

Future purchaseVIPTicket(
    {Client client,
      Trip trip,
      int numberOfTickets,
      int total,
      int amountPaid,
      String status,
      bool success,
      String transactionId,
      String txRef}) async {
  try {
    String num = await getRandomNumber();
    final data = {
      'companyId': trip.companyData['id'],
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocation': trip.departure['name'],
      'arrivalLocation': trip.arrival['name'],
      'numberOfTickets': numberOfTickets,
      'user': clientsCollection.doc(client.uid),
      'userId': client.uid,
      'total': total,
      'amountPaid': amountPaid,
      'ticketType':"VIP",
      'ticketNumber': num,
      'paymentStatus': status,
      'paymentSuccessFul': success,
      'paymentTransactionId': transactionId,
      'paymentTxRef': txRef,
      'status': "pending",
      'createdAt': DateTime.now(),
    };

    await ticketsCollection.add(data);

    await addClientNotification(
      clientId: client.uid,
      busCompanyId: trip.companyData['id'],
      title: "New VIP Ticket",
      body: num +" Ticket Has Been Purchased Successfully",
    );

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    return await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
  } catch (e) {
    print(e.toString());
  }
}

Stream<List<TripTicket>> getMyTickets({String uid}) {
  return FirebaseFirestore.instance
      .collection("tickets")
      .where("userId", isEqualTo: uid)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Stream<List<TripTicket>> getMyTicketsForBusCompany(
    {String uid, String companyId}) {
  return FirebaseFirestore.instance
      .collection("tickets")
      .where("userId", isEqualTo: uid)
      .where("companyId", isEqualTo: companyId)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}
