import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/busCompany/BusCompanyMyTickets.dart';
import 'package:bus_stop/views/busCompany/BusCompanyProfile.dart';
import 'package:flutter/material.dart';

import 'BusCompanyDestinations.dart';
import 'BusCompanyTrips.dart';

class BusCompanyScreen extends StatefulWidget {
  final Client client;
  const BusCompanyScreen({Key key, this.client}) : super(key: key);

  @override
  _BusCompanyScreenState createState() => _BusCompanyScreenState();
}

class _BusCompanyScreenState extends State<BusCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfffdfdfd),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20, height: 25,
                child: Image.asset('assets/images/back_arrow.png',)),
          ),
          title:
          Text("Select Bus Company".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      body: StreamBuilder(
        stream: getAllBusCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<BusCompany> data = snapshot.data;
            return SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: (){
                        _openBottomSheet(company: data[index]);
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].name),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _openBottomSheet({ BusCompany company }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(company: company);
        });
  }

  Widget _getTicketOptions({ BusCompany company }) {
    final options = [
      "Trips",
      "Tickets",
      "Destinations",
      "Bus Company Profile"
    ];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) =>
            ListTile(
              onTap: () =>
              {
                if(option == "Trips"){
                  Navigator.of(context).pop(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusCompanyTrips(
                                client: widget.client,
                                company: company,
                              )
                      ))
                },
                if(option == "Tickets"){
                  Navigator.of(context).pop(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusCompanyMyTickets(
                                client: widget.client,
                                company: company,)
                      ))
                },
                if(option == "Destinations"){
                  Navigator.of(context).pop(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusCompanyDestinations(
                                company: company,
                              )))
                },
                if(option == "Bus Company Profile"){
                  Navigator.of(context).pop(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusCompanyProfile(
                                company: company,
                              )))
                }
              },
              title: Column(
                children: [
                  Text(
                    option,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Color(0xFFE4191D)),
                  ),
                  const SizedBox(height: 4),
                  const Divider(height: 1)
                ],
              ),
            ))
            .toList(),
      ),
    );
  }
}
