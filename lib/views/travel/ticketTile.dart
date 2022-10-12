import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/travel/ticketDetail.dart';
import 'package:bus_stop/views/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class TicketTile extends StatefulWidget {
  final Client client;
  final TripTicket tripTicket;

  const TicketTile({Key key,this.client,this.tripTicket}) : super(key: key);

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  String companyName = "";

  getCompanyInfo() async {
    String ref = widget.tripTicket.trip.company.path;
    DocumentSnapshot snap = await FirebaseFirestore.instance.doc(ref).get();
    if (mounted) {
      setState(() {
        companyName = snap.get("name");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompanyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketDetails(
                  client: widget.client,
                      tripTicket: widget.tripTicket,
                      companyName: companyName,
                      tripPrice: widget.tripTicket.trip.price.toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Container(
            width: 300,
            height: 310,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red,
                )),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                widget.tripTicket.ticketNumber.toUpperCase(),
                                // widget.tripTicket.trip.id,
                                style: const TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  color: widget.tripTicket.ticketType == "Ordinary" ? Color(0xffE4181D) : Color(0xffeede90),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dateToTime(
                                      widget.tripTicket.trip.departureTime)),
                                  Text(dateToTime(widget.tripTicket.trip.arrivalTime)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xffED696C),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 3,
                                      // width: 10,
                                      color: Color(0xffED696C),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xffED696C),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child:
                                          Text(widget.tripTicket.departureLocation),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:
                                          Text(widget.tripTicket.arrivalLocation),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            companyName == ""
                                ? Container()
                                : Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Company"),
                                              Text(companyName),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Date"),
                                        Text(dateToStringNew(
                                            widget.tripTicket.trip.departureTime))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Amount Paid"),
                                        Text(widget.tripTicket.total
                                                .toString() +
                                            " SHS"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Number Of Tickets"),
                                    Container(
                                        width: 50,
                                        height: 40,
                                        alignment: Alignment.center,
                                        // color: Color(0xffED696C),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            Text(
                                              widget.tripTicket.numberOfTickets
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color(0xffED696C),
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ))
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
                Positioned(
                    bottom: 15,
                    left: -10,
                    child: Container(
                      width: 35,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.tripTicket.status == "pending"
                              ? Colors.green
                              : Colors.black87,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        widget.tripTicket.status == "pending" ? "Y" : "x",
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
