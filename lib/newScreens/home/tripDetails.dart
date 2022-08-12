import 'dart:async';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:bus_stop/shared/decorations.dart';
import 'package:bus_stop/shared/loading.dart';
import 'package:bus_stop/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TripDetails extends StatefulWidget {
  final Trip trip;
  const TripDetails({this.trip});

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final String currency = FlutterwaveCurrency.UGX;
  int ticketNumber = 1;
  String error = '';
  bool loading = false;
  bool isSuccessful = false;
  int i = 0;

  String username = '';
  String email = '';
  String phone = '';

  final CollectionReference clientProfile =
  FirebaseFirestore.instance.collection('clients');

  getUserDetails() async{
    String userID = FirebaseAuth.instance.currentUser.uid;
    if(userID != null)
    await clientProfile.doc(userID).get().then((DocumentSnapshot snap) => {
      username = snap.get("username"),
      email = snap.get("email"),
      phone = snap.get("phoneNumber")
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails().whenComplete((){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<Client>(context, listen: false).uid;
    return loading ? Container(child: Center(child: Loading())) : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,height: 25,
              child: Image.asset('assets/images/back_arrow.png',)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 430,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(widget.trip.id,
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xffE4181D),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(dateToTime(widget.trip.depatureTime)),
                                      Text(dateToTime(widget.trip.eta)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 20,height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xffED696C),
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Colors.white,width: 2)
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                          // width: 10,
                                          color: Color(0xffED696C),
                                        ),
                                      ),
                                      Container(
                                        width: 20,height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xffED696C),
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Colors.white,width: 2)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(widget.trip.departure['name']),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(widget.trip.arrival['name']),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Company Name"),
                                          Text(widget.trip.companyData['name'])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Date"),
                                          Text(dateToStringNew(widget.trip.depatureTime))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text("Total Seats"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                            height: 40,
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(widget.trip.totalSeats.toString(),
                                            style: TextStyle(color: Colors.white),
                                            ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED696C),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text("Remaining Seats"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Text((widget.trip.totalSeats - widget.trip.occupiedSeats)
                                              .toString(),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED696C),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text("Number Of Tickets"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          onChanged: (val) =>
                                          {setState(() => ticketNumber = int.parse(val))},
                                          decoration:
                                          textFormFieldDecoration.copyWith(hintText: '1'),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment : Alignment.bottomLeft,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                          ),
                        ),
                      ),
                      Align(
                        alignment : Alignment.bottomRight,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
                          ),
                        ),
                      )
                    ],
                  )
              ),
              Container(
                width: 300,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    DottedLine(),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                              child: QrImage(
                      data: "Not Paid",
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment : Alignment.topLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
                        ),
                      ),
                    ),
                    Align(
                      alignment : Alignment.topRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
                        ),
                      ),
                    ),
                    error.length > 0 ?
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top:50.0),
                        child: Text(error),
                      ),
                    ) : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isSuccessful ? Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                child: Text("Successfully Bought A Ticket",
                  style: TextStyle(color: Color(0xffE4181D), fontSize: 15),
                ),
              ):
              GestureDetector(
              onTap: () async{
                final remainingSeats =
                    widget.trip.totalSeats - widget.trip.occupiedSeats;
                if (ticketNumber > remainingSeats) {
                  setState(() {
                    error = 'Invalid number of tickets';
                    loading = false;
                  });
                  return;
                }
               final total = ticketNumber * widget.trip.price;
                if(username != "")
                await _handlePaymentInitialization(uid, widget.trip,ticketNumber, total);
              },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("Buy Tickets",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffE4181D),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              ),
              SizedBox(height: 5,)
            ],
          ),
        ),
      ),
    );
  }

  _handlePaymentInitialization(String uid, Trip trip, int numberOfTickets, int total) async {
    final Firestore fireStore = Firestore(uid: uid);
    final flutterWave = Flutterwave.forUIPayment(
        amount: total.toString().trim(),
        currency: this.currency,
        context: this.context,
        publicKey: "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X",
        encryptionKey: "5c86f7935b3b4596704a7520",
        email: email,
        fullName: username,
        txRef: DateTime.now().toIso8601String(),
        narration: "Bus Stop",
        isDebugMode: false,
        phoneNumber: phone,
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true
    );
    try{
      final response = await flutterWave.initializeForUiPayments();

      if (response == null) {
        // user didn't complete the transaction.
      } else {
        if(response.status == FlutterwaveConstants.SUCCESSFUL){
        }else{
          int amountPaid = int.parse(response.data.amount);
          setState(() {
            loading = true;
            error = '';
          });
          await fireStore.buyTicket(widget.trip, ticketNumber, total,amountPaid);

          if(total != amountPaid) {
            setState(() {
              loading = false;
              error = 'You Paid ' + amountPaid.toString() + " Out of " + total.toString();
              isSuccessful = true;
              Timer.periodic(Duration(milliseconds: 1500), (Timer timer){
                  timer.cancel();
                  Navigator.pop(context);
                });
            });
          }else{
            setState(() {
              loading = false;
              error = '';
              isSuccessful = true;
              Timer.periodic(Duration(milliseconds: 1000), (Timer timer){
                timer.cancel();
                Navigator.pop(context);
              });
            });
          }
        }
     }
    } catch (err){
      setState(() {
        loading = false;
        error = err.toString();
      });
    }
  }
}
