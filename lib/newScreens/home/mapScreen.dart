import 'dart:async';
import 'package:bus_stop/models/destination.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Destination destination;

  const MapScreen({Key key,this.destination}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        iconTheme: IconThemeData(color: Colors.red[900]),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text(
          widget.destination.name.toUpperCase() +" "+ "BUS STATION",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red[900]),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
