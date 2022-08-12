import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/newScreens/home/cargoDetails.dart';
import 'package:bus_stop/newScreens/home/tripDetails.dart';
import 'package:bus_stop/shared/utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TripTile extends StatelessWidget {
  final String orderType;
  final Trip trip;
  const TripTile({this.trip,this.orderType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){
      orderType == "Cargo" ?
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CargoDetails(trip: trip,))):
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TripDetails(trip: trip,)));
    },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  trip.departure['name'],
                  style: TextStyle(color: Colors.black54,
                  fontSize: 13
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 1,
                  width: 20,
                  color: Colors.red[900],
                ),
                SizedBox(
                  width: 5,
                ),
                Text(trip.arrival['name'],
                  style: TextStyle(color: Colors.black54,
                      fontSize: 13
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xfffdfdfd),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffED696C),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              width: 60,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dateToTime(trip.depatureTime),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 55,
                                  ),
                                  Text(
                                    dateToTime(trip.eta),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                      // height: 50,
                                      width: 3,
                                      color: Colors.white,
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
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 10, right: 5, top: 8),
                                    child: Container(
                                      child: Text(
                                        trip.departure['name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // Container(height: 55,),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 8, right: 5, top: 1),
                                    child: Container(
                                      child: Text(
                                        trip.arrival['name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    trip.companyData['name'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Color(0xfffdfdfd),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Color(0xfffdfdfd),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50))),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 15,
                        child: Container(child: Text(dateToStringNew(trip.depatureTime),
                        style: TextStyle(color: Colors.white),
                        ),) ),
                  ],
                )),
            Container(
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffED696C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  DottedLine(
                    dashColor: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color(0xfffdfdfd),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color(0xfffdfdfd),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: orderType == "Cargo" ?
                    Container(
                      width: 99,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    )
                        :Container(
                      width: 99,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        trip.price.toString() +" SHS",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
