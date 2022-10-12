import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:get/get.dart';

class TicketPayment extends StatefulWidget {
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int noOfTickets;
  final int totalAmount;

  const TicketPayment(
      {Key key, this.client, this.trip,this.ticketChoice ,this.noOfTickets, this.totalAmount})
      : super(key: key);

  @override
  _TicketPaymentState createState() => _TicketPaymentState();
}

class _TicketPaymentState extends State<TicketPayment> {
  final amountController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String selectedCurrency = "";

  @override
  void initState() {
    setState(() {
      // publicKeyController.text =
      // "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
      publicKeyController.text = "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X";
      encryptionKeyController.text = "5c86f7935b3b4596704a7520";
      emailController.text = widget.client.email;
      amountController.text = widget.totalAmount.toString();
      selectedCurrency = "UGX";
    });
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
      body: Center(
        child: Loading(),
      ),
    )
        : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text(
            "Ticket Payment",
            style: TextStyle(color: Color(0xffE4181D)),
          ),
          centerTitle: false,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          )),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: amountController,
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                decoration:
                const InputDecoration(labelText: "Amount To Be Paid"),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                readOnly: true,
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Your Account Email",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: phoneNumberController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Confirm Your Phone Number",
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: RaisedButton(
                onPressed: _onPressed,
                color: const Color(0xffE4181D),
                child: const Text(
                  "Make Payment",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (phoneNumberController.text.trim().length >= 10) {
      _handlePaymentInitialization();
    } else {
      Get.snackbar("Missing Data", "Confirm Your Phone Number",
          backgroundColor: Colors.grey);
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Bus Stop Payment",
      buttonColor: const Color(0xffd0ebff),
      buttonTextStyle: const TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
      ),
      appBarColor: Colors.grey[200],
      dialogCancelTextStyle: const TextStyle(
        color: Colors.brown,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.grey[200],
      mainTextStyle: const TextStyle(
          color: Color(0xffE4181D), fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: const Icon(Icons.receipt, color: Color(0xffE4181D)),
      buttonText: "Pay $selectedCurrency ${amountController.text}",
      appBarTitleTextStyle: const TextStyle(
        color: Color(0xffE4181D),
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: widget.client.username,
        phoneNumber: phoneNumberController.text,
        email: emailController.text);

    final Flutterwave flutterWave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKeyController.text,
        currency: selectedCurrency,
        redirectUrl: "https://google.com",
        txRef: DateTime.now().toIso8601String(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter",
        customization: Customization(title: "Bus Stop Ticket Payment"),
        isTestMode: false);

    final ChargeResponse response = await flutterWave.charge();
    if (response != null) {
      setState(() {
        isLoading = true;
      });
      if(widget.ticketChoice == "Ordinary"){
        await purchaseOrdinaryTicket(
            client: widget.client,
            trip: widget.trip,
            numberOfTickets: widget.noOfTickets,
            total: widget.totalAmount,
            amountPaid: 0,
            status: response.status,
            success: response.success,
            transactionId: response.transactionId,
            txRef: response.txRef);
      }else{
        await purchaseVIPTicket(
            client: widget.client,
            trip: widget.trip,
            numberOfTickets: widget.noOfTickets,
            total: widget.totalAmount,
            amountPaid: 0,
            status: response.status,
            success: response.success,
            transactionId: response.transactionId,
            txRef: response.txRef);
      }
      setState(() {
        isLoading = false;
      });
      showLoading(response.status);
      print("${response.toJson()}");
    } else {
      showLoading("No Response!");
    }
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Text(
                  "Pay Again",
                  style: TextStyle(color: Colors.green),
                )),
            const SizedBox(width: 5,),
            GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Color(0xffE4181D)),
                ))
          ],
        );
      },
    );
  }
}
