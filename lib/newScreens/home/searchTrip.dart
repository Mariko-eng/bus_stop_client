import 'package:bus_stop/contollers/lcoProvider.dart';
import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/newScreens/home/busStops.dart';
import 'package:bus_stop/newScreens/home/destinations.dart';
import 'package:bus_stop/newScreens/home/tickets.dart';
import 'package:bus_stop/newScreens/home/tripsList.dart';
import 'package:bus_stop/services/auth.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SearchTrip extends StatefulWidget {
  final String orderType;

  const SearchTrip({Key key, this.orderType}) : super(key: key);

  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  Firestore firestore = Firestore();
  List<Trip> trips;
  String dateInputText = "";

  getTrips(String departureLocation, String arrivalLocation) async {
    final results =
        await firestore.searchTrips(departureLocation, arrivalLocation);
    setState(() {
      trips = results;
    });
  }

  final AuthService _auth = AuthService();
  bool show = true;

  Destination _fromDest;
  Destination _toDest;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    LocationsProvider _locProvider = Provider.of<LocationsProvider>(context);
    final destinations = Provider.of<List<Destination>>(context) ?? [];

    if (_locProvider.destinationFrom != null) {
      setState(() {
        _fromController.text = _locProvider.destinationFrom.name;
        _fromDest = _locProvider.destinationFrom;
      });
    }

    if (_locProvider.destinationTo != null) {
      setState(() {
        _toController.text = _locProvider.destinationTo.name;
        _toDest = _locProvider.destinationTo;
      });
    }

    return Scaffold(
      appBar: widget.orderType == "Cargo"
          ? AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.red[900]),
              backgroundColor: Colors.grey[200],
              centerTitle: true,
              title: Text(
                widget.orderType.toUpperCase(),
                style: TextStyle(color: Colors.red[900]),
              ),
            )
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.red[900],
              centerTitle: true,
              title: Text(widget.orderType.toUpperCase()),
            ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/map.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                show
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BusStops(
                                                        destinations: destinations,
                                                      )));
                                        },
                                        child: SizedBox(
                                          width: 200,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.directions_bus,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 100,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Maps",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                show
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          if (widget.orderType == "Cargo") {
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TripTickets()));
                                          }
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.confirmation_num,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (widget.orderType ==
                                                      "Cargo") {
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TripTickets()));
                                                  }
                                                },
                                                child: widget.orderType ==
                                                        "Cargo"
                                                    ? Container(
                                                        height: 40,
                                                        width: 100,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          "Parcels",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.red[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 100,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          "Tickets",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.red[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                show
                                    ? Container()
                                    : Container(
                                        width: 200,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await _auth.signOut();
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.logout,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await _auth.signOut();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Logout",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                !show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: !show
                                        ? Stack(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                    'assets/images/stop.png'),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          )
                                        : Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/image1.png'),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.orderType == "Cargo"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50),
                                                    child: Text(
                                                      "Choose Your PickUp And",
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50),
                                                    child: Text(
                                                      "DropOff Locations..",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50),
                                                    child: Text(
                                                      "Where would you like",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50),
                                                    child: Text(
                                                      "to go today?",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            child: Container(
                                              // height: 200,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF4F7FA),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30,
                                                            bottom: 25,
                                                            left: 10),
                                                    width: 50,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                            const Expanded(
                                                              child: DottedLine(
                                                                // lineLength: double.minPositive,
                                                                dashColor:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: DottedLine(
                                                              direction:
                                                                  Axis.vertical,
                                                              dashColor:
                                                                  Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child:
                                                                    const DottedLine(
                                                                  dashColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    width: 240,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          width: 220,
                                                          height: 60,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                // top: 0,
                                                                // left: 40,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 220,
                                                                  height: 50,
                                                                  child:
                                                                      TextField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                        label: Container(
                                                                          width:
                                                                              220,
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.location_on_outlined,
                                                                                size: 30,
                                                                                color: Colors.red,
                                                                              ),
                                                                              const Text("From"),
                                                                              Expanded(child: Container()),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                    onTap: () {
                                                                      showModalBottomSheet(
                                                                          shape: const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.vertical(
                                                                                  top: Radius.circular(
                                                                                      25.0))),
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          context:
                                                                              context,
                                                                          isScrollControlled:
                                                                              true,
                                                                          builder: (context) =>
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height * 0.90,
                                                                                child: Destinations(
                                                                                  locType: "from",
                                                                                  destinations: destinations,
                                                                                ),
                                                                              ));
                                                                    },
                                                                    controller:
                                                                        _fromController,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Container(),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                              width: 220,
                                                              height: 60,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    // top: 10,
                                                                    // left: 40,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width:
                                                                          220,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          TextField(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        readOnly:
                                                                            true,
                                                                        decoration: InputDecoration(
                                                                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                            label: Container(
                                                                              width: 220,
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  const Icon(
                                                                                    Icons.location_on_outlined,
                                                                                    size: 30,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  const Text("To"),
                                                                                  Expanded(child: Container()),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                        onTap:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                                                                              backgroundColor: Colors.white,
                                                                              context: context,
                                                                              isScrollControlled: true,
                                                                              builder: (context) => SizedBox(
                                                                                    height: MediaQuery.of(context).size.height * 0.90,
                                                                                    child: Destinations(
                                                                                      locType: "to",
                                                                                      destinations: destinations,
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        controller:
                                                                            _toController,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              children: [
                                                // Expanded(
                                                //   child: Padding(
                                                //     padding: const EdgeInsets
                                                //             .symmetric(
                                                //         horizontal: 50),
                                                //     child: Container(
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .spaceBetween,
                                                //         children: [
                                                //           GestureDetector(
                                                //             onTap: () async {
                                                //               DateTime pickedDate = await showDatePicker(
                                                //                   context:
                                                //                       context,
                                                //                   initialDate:
                                                //                       DateTime
                                                //                           .now(),
                                                //                   firstDate:
                                                //                       DateTime
                                                //                           .now(),
                                                //                   lastDate:
                                                //                       DateTime(
                                                //                           2101));
                                                //
                                                //               if (pickedDate !=
                                                //                   null) {
                                                //                 print(
                                                //                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                //                 String
                                                //                     formattedDate =
                                                //                     DateFormat(
                                                //                             'yyyy-MM-dd')
                                                //                         .format(
                                                //                             pickedDate);
                                                //                 print(
                                                //                     formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //                 //you can implement different kind of Date Format here according to your requirement
                                                //
                                                //                 setState(() {
                                                //                   dateInputText =
                                                //                       formattedDate; //set output date to TextField value.
                                                //                 });
                                                //               } else {
                                                //                 print(
                                                //                     "Date is not selected");
                                                //               }
                                                //             },
                                                //             child: Row(
                                                //               children: const [
                                                //                 Icon(
                                                //                   Icons
                                                //                       .calendar_today,
                                                //                   color: Color(
                                                //                       0xffE4181D),
                                                //                 ),
                                                //                 Text("Today"),
                                                //               ],
                                                //             ),
                                                //           ),
                                                //           Row(
                                                //             children: const [
                                                //               Text("1"),
                                                //               Text("Passenger"),
                                                //             ],
                                                //           )
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 30,
                                                        vertical: 10),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if (_fromDest != null &&
                                                            _toDest != null) {
                                                          await getTrips(
                                                              _fromDest.id,
                                                              _toDest.id);
                                                        }
                                                        if (trips != null) {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Trips(
                                                                            trips:
                                                                                trips,
                                                                            orderType:
                                                                                widget.orderType,
                                                                          )));
                                                        }
                                                      },
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 50,
                                                          decoration: widget
                                                                      .orderType ==
                                                                  "Cargo"
                                                              ? BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20.0),
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xffE4181D)))
                                                              : BoxDecoration(
                                                                  color: const Color(
                                                                      0xffE4181D),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20.0)),
                                                          child: Text(
                                                            "Search Trip",
                                                            style: widget.orderType ==
                                                                    "Cargo"
                                                                ? TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                            .red[
                                                                        900])
                                                                : const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
