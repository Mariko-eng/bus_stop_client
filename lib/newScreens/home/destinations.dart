import 'package:bus_stop/contollers/lcoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/destination.dart';

class Destinations extends StatefulWidget {
  final String locType;
  final List<Destination> destinations;

  const Destinations({this.locType, this.destinations, Key key})
      : super(key: key);

  @override
  _DestinationsState createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations> {
  final TextEditingController _searchCtr = TextEditingController();
  List<Destination> searchResults = [];

  @override
  Widget build(BuildContext context) {
    LocationsProvider _locProvider = Provider.of<LocationsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _searchCtr,
                onChanged: (v) {
                  if (_searchCtr.text.trim().isNotEmpty) {
                    if (widget.destinations.isNotEmpty) {
                      List<Destination> _r = [];
                      for (int i = 0; i < widget.destinations.length; i++) {
                        if (widget.destinations[i].name
                            .toLowerCase()
                            .contains(_searchCtr.text.toLowerCase())) {
                          _r.add(widget.destinations[i]);
                        }
                      }
                      setState(() {
                        searchResults = _r;
                      });
                    }
                  } else {
                    setState(() {
                      searchResults = [];
                    });
                  }
                },
                decoration: const InputDecoration(labelText: "Search Place"),
              ),
            ),
          ),
          Positioned(
              top: 55,
              child: searchResults.length == 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: widget.destinations.length,
                          itemBuilder: (context, int i) {
                            return ListTile(
                              onTap: () {
                                if (widget.locType == "from") {
                                  _locProvider.setDestinationFrom(
                                      widget.destinations[i]);
                                } else {
                                  _locProvider.setDestinationTo(
                                      widget.destinations[i]);
                                }
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              title: Text(widget.destinations[i].name),
                            );
                          }),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, int i) {
                            return ListTile(
                              onTap: () {
                                if (widget.locType == "from") {
                                  _locProvider
                                      .setDestinationFrom(searchResults[i]);
                                } else {
                                  _locProvider
                                      .setDestinationTo(searchResults[i]);
                                }
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              title: Text(searchResults[i].name),
                            );
                          }),
                    ))
        ],
      ),
    );
  }
}
