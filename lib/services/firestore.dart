import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final String uid;
  Firestore({this.uid});

  final CollectionReference clientProfile =
      FirebaseFirestore.instance.collection('clients');
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');
  final CollectionReference destinationsCollection =
      FirebaseFirestore.instance.collection('destinations');
  final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');

  Future createProfile(
      String email, String phoneNumber, String username) async {
    return await clientProfile.doc(uid).set(
        {'email': email, 'phoneNumber': phoneNumber, 'username': username});
  }

  Future buyTicket(Trip trip, int numberOfTickets, int total, int amountPaid) async {
    try {
      final data = {
        'trip': tripsCollection.doc(trip.id),
        'tripId': trip.id,
        'departureLocation': trip.departure['name'],
        'arrivalLocation': trip.arrival['name'],
        'numberOfTickets': numberOfTickets,
        'user': clientProfile.doc(this.uid),
        'userId': this.uid,
        'total': total,
        'amountPaid': amountPaid,
        'createdAt': DateTime.now(),
      };

      await ticketsCollection.add(data);

      DocumentReference tripRef = tripsCollection.doc(trip.id);
      return await tripRef
          .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
    } catch (e) {
      print(e.toString());
    }
  }

  List<Trip> _tripListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map data = doc.data();

      return Trip(
        arrivalLocation: data['arrivalLocation'],
        departureLocation: data['departureLocation'],
        company: data['company'],
        eta: data['eta'].toDate(),
        depatureTime: data['depatureTime'].toDate(),
        id: doc.id,
        price: data['price'],
        occupiedSeats: data['occupiedSeats'],
        totalSeats: data['totalSeats'],
      );
    }).toList();
  }

  List<TripTicket> _tripTicketFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map data = doc.data();
      return TripTicket(
        departureLocation: data['departureLocation'],
        arrivalLocation: data['arrivalLocation'],
        numberOfTickets: data['numberOfTickets'],
        ticketId: doc.id,
        createdAt: data['createdAt'],
        amountPaid: data['amountPaid'],
        total: data['total'],
        tripRef: data['trip'],
      );
    }).toList();
  }

  List<Destination> _destinationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Destination(id: doc.id, name: doc.get('name'));
    }).toList();
  }

  Stream<List<Trip>> get trips {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

    return tripsCollection
        .where('depatureTime', isGreaterThanOrEqualTo: yesterday)
        .orderBy('depatureTime')
        .snapshots()
        .map(_tripListFromSnapshot);
  }

  Stream<List<Destination>> get destinations {
    return destinationsCollection
        .orderBy('name')
        .snapshots()
        .map(_destinationListFromSnapshot);
  }

  Stream<List<TripTicket>> get tripTickets {
    return ticketsCollection
        .where('userId', isEqualTo: this.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_tripTicketFromSnapshot);
  }

  Future<List<Trip>> searchTrips(
      String departureLocation, String arrivalLocation) async {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day -1, now.hour, now.minute);

    QuerySnapshot snapshot = await tripsCollection
        .where('depatureTime', isGreaterThan: yesterday)
        .where('arrivalLocationId', isEqualTo: arrivalLocation.trim())
        .where('departureLocationId', isEqualTo: departureLocation.trim())
        .get();
    return _tripListFromSnapshot(snapshot);
  }
}
