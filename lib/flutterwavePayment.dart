import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  const Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  // final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  // bool isTestMode = true;
  // final pbk = "FLWPUBK_TEST";

  @override
  void initState() {
    setState(() {
      publicKeyController.text = "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
      //publicKeyController.text = "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X";
      encryptionKeyController.text = "5c86f7935b3b4596704a7520";
      selectedCurrency = "UGX";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // this.currencyController.text = this.selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: Text("payement"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                  value.isNotEmpty ? null : "Amount is required",
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              //   child: TextFormField(
              //     controller: currencyController,
              //     textInputAction: TextInputAction.next,
              //     style: const TextStyle(color: Colors.black),
              //     readOnly: true,
              //     onTap: _openBottomSheet,
              //     decoration: const InputDecoration(
              //       hintText: "Currency",
              //     ),
              //     validator: (value) =>
              //     value.isNotEmpty ? null : "Currency is required",
              //   ),
              // ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              //   child: Row(
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Use Debug"),
              //       Switch(
              //         onChanged: (value) => {
              //           setState(() {
              //             isTestMode = value;
              //           })
              //         },
              //         value: this.isTestMode,
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: this._onPressed,
                  color: Colors.blue,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (this.formKey.currentState.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "My Standard Blue",
      buttonColor: Color(0xffd0ebff),
      buttonTextStyle: const TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
      ),
      appBarColor: Color(0xff8fa33b),
      dialogCancelTextStyle: const TextStyle(
        color: Colors.brown,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.indigo,
      mainTextStyle: const TextStyle(
          color: Colors.indigo,
          fontSize: 19,
          letterSpacing: 2
      ),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: Icon(Icons.message, color: Colors.purple),
      buttonText: "Pay $selectedCurrency${amountController.text}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: "FLW Developer",
        phoneNumber: this.phoneNumberController.text ?? "12345678",
        email: "customer@customer.com");

    // final subAccounts = [
    //   SubAccount(id: "RS_1A3278129B808CB588B53A14608169AD", transactionChargeType: "flat", transactionPercentage: 25),
    //   SubAccount(id: "RS_C7C265B8E4B16C2D472475D7F9F4426A", transactionChargeType: "flat", transactionPercentage: 50)
    // ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKeyController.text,
        // publicKey: this.publicKeyController.text.trim().isEmpty
        //     ? this.getPublicKey()
        //     : this.publicKeyController.text.trim(),
        currency: selectedCurrency,
        redirectUrl: "https://google.com",
        // txRef: Uuid().v1(),
        txRef: DateTime.now().toIso8601String(),
        amount: this.amountController.text.toString().trim(),
        customer: customer,
        // subAccounts: subAccounts,
        paymentOptions: "card, payattitude, barter",
        customization: Customization(title: "Test Payment"),
        isTestMode: true
    );

    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {

      this.showLoading(response.status);
      print("${response.toJson()}");
    } else {
      this.showLoading("No Response!");
    }
  }

  // String getPublicKey() {
  //   if (isTestMode) return "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
  //   // "FLWPUBK_TEST-02b9b5fc6406bd4a41c3ff141cc45e93-X";
  //   return "FLWPUBK-aa4cd0b443404147d2d8229a37694b00-X";
  // }

  // void _openBottomSheet() {
  //   showModalBottomSheet(
  //       context: this.context,
  //       builder: (context) {
  //         return this._getCurrency();
  //       });
  // }

  // Widget _getCurrency() {
  //   final currencies = ["NGN", "RWF", "UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
  //   return Container(
  //     height: 250,
  //     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //     color: Colors.white,
  //     child: ListView(
  //       children: currencies
  //           .map((currency) => ListTile(
  //         onTap: () => {this._handleCurrencyTap(currency)},
  //         title: Column(
  //           children: [
  //             Text(
  //               currency,
  //               textAlign: TextAlign.start,
  //               style: TextStyle(color: Colors.black),
  //             ),
  //             SizedBox(height: 4),
  //             Divider(height: 1)
  //           ],
  //         ),
  //       ))
  //           .toList(),
  //     ),
  //   );
  // }

  // _handleCurrencyTap(String currency) {
  //   this.setState(() {
  //     this.selectedCurrency = currency;
  //     this.currencyController.text = currency;
  //   });
  //   Navigator.pop(this.context);
  // }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
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
              onTap: (){
                Get.back();
              },
                child: Text("OK",style: TextStyle(color: Colors.blue),))
          ],
        );
      },
    );
  }
}