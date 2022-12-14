import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/newScreens/home/ticketTile.dart';
import 'package:bus_stop/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripsTicketList extends StatefulWidget {

  @override
  _TripsTicketListState createState() => _TripsTicketListState();
}

class _TripsTicketListState extends State<TripsTicketList> {
  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<List<TripTicket>>(context) ?? [];

    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: true,
        title: Text("My Tickets",
        style: TextStyle(color: Color(0xffE4181D)),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,height: 25,
              child: Image.asset('assets/images/back_arrow.png',)),
        ),
      ),
      body: tickets.length == 0
          ? Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          width: double.infinity,
          child: Text(
            'No tickets',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4191D),
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
          : ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: tickets[index].setTripData(context),
            // ignore: missing_return
            builder: (context, snapshot) {
              final ticket = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  if (index == 0) {
                    return Loading();
                  }

                  return Container();
                case ConnectionState.none:
                  return Container(
                    child: Text(
                      'No Tickets',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFE4191D), fontSize: 20.0),
                    ),
                  );
                case ConnectionState.active:
                  return Text('Searching... ');
                case ConnectionState.done:
                  return TicketTile(tripTicket: ticket);
              }
            },
          );
        },
      ),
    );
  }
}
