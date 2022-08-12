import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/newScreens/home/ticketsList.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/models/user.dart';

class TripTickets extends StatefulWidget {

  @override
  _TripTicketsState createState() => _TripTicketsState();
}

class _TripTicketsState extends State<TripTickets> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<Client>(context, listen: false).uid;
    return StreamProvider<List<TripTicket>>.value(
      value: Firestore(uid: uid).tripTickets,
      child : TripsTicketList(),
    );
  }
}
