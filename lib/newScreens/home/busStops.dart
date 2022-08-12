import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/newScreens/home/mapScreen.dart';
import 'package:flutter/material.dart';

class BusStops extends StatefulWidget {
  final List<Destination> destinations;

  const BusStops({Key key, this.destinations}) : super(key: key);

  @override
  _BusStopsState createState() => _BusStopsState();
}

class _BusStopsState extends State<BusStops> {
  final TextEditingController _searchCtr = TextEditingController();
  List<Destination> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[900]),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text(
          "Bus Stop Stations",
          style: TextStyle(
            fontSize: 18,
              color: Colors.red[900]),
        ),
        actions: [
          Icon(
            Icons.location_on,
            color: Colors.red[900],
          ),
          SizedBox(width: 10,)
        ],
      ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blueGrey,
                        ),
                        labelText: "Search Place"),
                  ),
                ),
              ),
              Positioned(
                  top: 65,
                  child: searchResults.length == 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                                itemCount: widget.destinations.length,
                                itemBuilder: (context, int i) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   MapScreen(
                                                    destination:
                                                        widget.destinations[i],
                                                  )));
                                    },
                                    title: Text(widget.destinations[i].name),
                                  );
                                }),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, int i) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 MapScreen(
                                                  destination:
                                                  searchResults[i],
                                                )));
                                  },
                                  title: Text(searchResults[i].name),
                                );
                              }),
                        ))
            ],
          ),
        ));
  }
}
