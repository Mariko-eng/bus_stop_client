import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/travel/TicketNewPayment.dart';
import 'package:bus_stop/views/shared/utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TripDetails extends StatefulWidget {
  final Client client;
  final Trip trip;

  const TripDetails({Key key, this.client, this.trip}) : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  TextEditingController noOfTicketsController = TextEditingController();
  int noOfTickets = 1;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      noOfTicketsController.text = noOfTickets.toString();
      totalAmount = widget.trip.price * noOfTickets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.trip.tripNumber,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE4181D),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(dateToTime(widget.trip.depatureTime)),
                                    Text(dateToTime(widget.trip.eta)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffED696C),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child:
                                          Text(widget.trip.departure['name']),
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
                              Padding(
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
                                        Text("Company Name"),
                                        Text(widget.trip.companyData['name'])
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Date"),
                                        Text(dateToStringNew(
                                            widget.trip.depatureTime))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
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
                                        height: 30,
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.trip.totalSeats.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xffED696C),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
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
                                        height: 30,
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text(
                                          (widget.trip.totalSeats -
                                                  widget.trip.occupiedSeats)
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xffED696C),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
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
                                      child: TextField(
                                        controller: noOfTicketsController,
                                        onChanged: (val) {
                                          if (val.trim().isNotEmpty) {
                                            int n = int.parse(val.trim());
                                            setState(() {
                                              noOfTickets = n;
                                              int amt = widget.trip.price * n;
                                              totalAmount = amt;
                                            });
                                          } else {
                                            setState(() {
                                              noOfTickets = 1;
                                              int amt = widget.trip.price * 1;
                                              totalAmount = amt;
                                            });
                                          }
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red))),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("Total Amount"),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        totalAmount.toString() + " SHS",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue[900]),
                                      ),
                                    ),
                                  ],
                                ),
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
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(50))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50))),
                        ),
                      )
                    ],
                  )),
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
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(50))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final remainingSeats =
                      widget.trip.totalSeats - widget.trip.occupiedSeats;
                  if (noOfTickets > remainingSeats) {
                    Get.snackbar("Error", 'Invalid number of tickets',
                        backgroundColor: Colors.grey[200]);
                    return;
                  }
                  Get.to(() => TicketPayment(
                        client: widget.client,
                        trip: widget.trip,
                        noOfTickets: noOfTickets,
                        totalAmount: totalAmount,
                      ));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "Buy Tickets",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  decoration: const BoxDecoration(
                      color: Color(0xffE4181D),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

// _handlePaymentInitialization(String uid, Trip trip, int numberOfTickets, int total) async {
//   final Firestore fireStore = Firestore(uid: uid);
//   final flutterWave = Flutterwave.forUIPayment(
//       amount: total.toString().trim(),
//       currency: this.currency,
//       context: this.context,
//       publicKey: "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X",
//       encryptionKey: "5c86f7935b3b4596704a7520",
//       email: email,
//       fullName: username,
//       txRef: DateTime.now().toIso8601String(),
//       narration: "Bus Stop",
//       isDebugMode: false,
//       phoneNumber: phone,
//       acceptAccountPayment: true,
//       acceptCardPayment: true,
//       acceptUSSDPayment: true
//   );
//   try{
//     final response = await flutterWave.initializeForUiPayments();
//
//     if (response == null) {
//       // user didn't complete the transaction.
//     } else {
//       if(response.status == FlutterwaveConstants.SUCCESSFUL){
//       }else{
//         int amountPaid = int.parse(response.data.amount);
//         setState(() {
//           loading = true;
//           error = '';
//         });
//         await fireStore.buyTicket(widget.trip, ticketNumber, total,amountPaid);
//
//         if(total != amountPaid) {
//           setState(() {
//             loading = false;
//             error = 'You Paid ' + amountPaid.toString() + " Out of " + total.toString();
//             isSuccessful = true;
//             Timer.periodic(Duration(milliseconds: 1500), (Timer timer){
//                 timer.cancel();
//                 Navigator.pop(context);
//               });
//           });
//         }else{
//           setState(() {
//             loading = false;
//             error = '';
//             isSuccessful = true;
//             Timer.periodic(Duration(milliseconds: 1000), (Timer timer){
//               timer.cancel();
//               Navigator.pop(context);
//             });
//           });
//         }
//       }
//    }
//   } catch (err){
//     setState(() {
//       loading = false;
//       error = err.toString();
//     });
//   }
// }
}
