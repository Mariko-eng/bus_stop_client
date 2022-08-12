import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/newScreens/home/searchTrip.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTravel extends StatefulWidget {
  final String userID;

  const HomeTravel({this.userID});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeTravel> {
  Firestore firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Destination>>.value(
      value: firestore.destinations,
      child: const SearchTrip(orderType: "Travel",),
    );
  }
}
