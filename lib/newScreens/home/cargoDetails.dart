import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/newScreens/home/checkOutCargo.dart';
import 'package:flutter/material.dart';

class CargoDetails extends StatefulWidget {
  final Trip trip;
  const CargoDetails({Key key, this.trip}) : super(key: key);

  @override
  _CargoDetailsState createState() => _CargoDetailsState();
}

class _CargoDetailsState extends State<CargoDetails> {
  TextEditingController itemDescController = TextEditingController();
  String option = "";
  String optionCharges = "";
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientTelNoController = TextEditingController();
  TextEditingController extraNotesController = TextEditingController();


  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  bool isSelected5 = false;
  bool isSelected6 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red[900], //change your color here
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
        title: Text("Enter Item Details",
            style: TextStyle(color: Colors.red[900])
          // style: GoogleFonts.roboto(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xff2046a1),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text(
                      "Enter Item Description".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      maxLines: 3,
                      style: TextStyle(color: Colors.blue[900]),
                      controller: itemDescController,
                      decoration: InputDecoration(
                          labelText: "Item Description",
                          labelStyle: const TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Icon(
                            Icons.folder,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Choose Item Dimensions".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900]),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: [
                        FilterChip(
                          label: const Text('30cm-x-30cm'),
                          selected: isSelected1,
                          labelStyle: TextStyle(
                              color: isSelected1 ? Colors.black : Colors.blue[700]),
                          selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected1 == false){
                              //   isSelected1 = true;
                              // }else{
                                isSelected1 = true;
                                isSelected2 = false;
                                isSelected3 = false;
                                isSelected4 = false;
                                isSelected5 = false;
                                isSelected6 = false;
                                option = "30cm-x-30cm";
                                optionCharges = "10000";
                              // }
                              // isSelected = !isSelected;
                            });
                          },
                        ),
                        FilterChip(
                          label: const Text('50cm-x-50cm'),
                          selected: isSelected2,
                          labelStyle: TextStyle(
                              color: isSelected2 ? Colors.black : Colors.blue[700]),
                          selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,
                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected2 == false){
                              //   isSelected2 = true;
                              // }else{
                                isSelected2 = true;
                                isSelected1 = false;
                                isSelected3 = false;
                                isSelected4 = false;
                                isSelected5 = false;
                                isSelected6 = false;
                                option = "50cm-x-50cm";
                                optionCharges = "15000";
                              // }
                          });
                          },
                        ),
                        FilterChip(
                          label: const Text('1m-x-1m'),
                          selected: isSelected3,
                          labelStyle: TextStyle(
                              color: isSelected3 ? Colors.black : Colors.blue[700]),
                          selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,
                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected3 == false){
                              //   isSelected3 = true;
                              // }else{
                                isSelected3 = true;
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected4 = false;
                                isSelected5 = false;
                                isSelected6 = false;
                                option = "1m-x-1m";
                                optionCharges = "20000";
                              // }
                            });
                          },
                        ),
                        FilterChip(
                          label: const Text('1.5m-x-1.5m'),
                          selected: isSelected4,
                          labelStyle: TextStyle(
                              color: isSelected4 ? Colors.black : Colors.blue[700]),
                          selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,
                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected4 == false){
                              //   isSelected4 = true;
                              // }else{
                                isSelected4 = true;
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected3 = false;
                                isSelected5 = false;
                                isSelected6 = false;
                                option = "1.5m-x-1.5m";
                                optionCharges = "25000";
                              // }
                            });
                          },
                        ),
                        FilterChip(
                          label: const Text('2m-x-2m'),
                          selected: isSelected5,
                          labelStyle: TextStyle(
                              color: isSelected5 ? Colors.black : Colors.blue[700]),
                          selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,
                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected5 == false){
                              //   isSelected5 = true;
                              // }else{
                                isSelected5 = true;
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected3 = false;
                                isSelected4 = false;
                                isSelected6 = false;
                                option = "2m-x-2m";
                                optionCharges = "30000";
                              // }
                            });
                          },
                        ),
                        FilterChip(
                          label: const Text('3m-x-3m'),
                          selected: isSelected6,
                          labelStyle: TextStyle(
                              color: isSelected6 ? Colors.black : Colors.blue[700]),
                            selectedColor:Colors.yellow[100],
                          checkmarkColor: Colors.deepOrange,
                          onSelected: (bool selected) {
                            setState(() {
                              // if(isSelected6 == false){
                              //   isSelected6 = true;
                              // }else{
                                isSelected6 = true;
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected3 = false;
                                isSelected4 = false;
                                isSelected5 = false;
                                option = "3m-x-3m";
                                optionCharges = "35000";
                              // }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "ENTER RECIPIENT INFORMATION",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900]),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(color: Colors.blue[900]),
                      controller: recipientNameController,
                      decoration: InputDecoration(
                        labelText: "Name of the Recipient",
                        labelStyle: const TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(
                          Icons.person_rounded,
                          color: Color(0xff2046a1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(color: Colors.blue[900]),
                      controller: recipientTelNoController,
                      decoration: InputDecoration(
                        labelText: "Phone Number of the Recipient",
                        labelStyle: const TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(
                          Icons.phone,
                          color: const Color(0xff2046a1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "ANY EXTRA NOTES?",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextField(
                      maxLines: 2,
                      style: TextStyle(color: Colors.blue[900]),
                      controller: extraNotesController,
                      decoration: InputDecoration(
                          labelText: "Extra Notes",
                          labelStyle: const TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Icon(
                            Icons.note,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
          // Expanded(child: Container()),
              if(option == "")
                Container()
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.deepOrange[900],
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Charges",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w100)
                        ),
                        Text(optionCharges + " SHS",
                          style: TextStyle(
                            fontSize: 18,
                              color: Colors.yellow[100],
                              fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    if (itemDescController.text.length < 10) {
                      const snackBar = SnackBar(
                          content: Text(
                              'Item Description should be at least 10 letters!'));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    } else if(option == ""){
                      const snackBar = const SnackBar(
                          content: const Text(
                              'Choose Your Item Dimensions!'));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    }
                    else if (recipientNameController.text.length < 3) {
                      const snackBar = const SnackBar(
                          content: Text(
                              'Recipient Name should be at least 3 letters!'));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    } else if (recipientTelNoController.text.length < 7) {
                      const snackBar = const SnackBar(
                          content:
                          const Text('Invalid Recipient Phone Number!'));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    } else {
                      _displayTextInputDialog(context,
                          recipientTelNoController.text);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  "Proceed To Checkout",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors
                                          .red[900] )
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20.0),
                                  border:
                                  Border.all(color: const Color(0xffE4181D)))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String phoneNumber) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Confirm The Recipient Phone Number Details",
              style: TextStyle(color: Colors.black87),
            ),
            content: Container(
              height: 100.0,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            phoneNumber,
                            style: const TextStyle(
                              fontSize: 18,
                                color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red[300],
                textColor: Colors.white,
                child: const Text(
                  'Edit',
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CheckOutCargo(
                      itemDesc: itemDescController.text.trim(),
                      itemDim: option,
                      itemDimCharges: optionCharges,
                      recName: recipientNameController.text.trim(),
                      recPhone: recipientTelNoController.text.trim(),
                      extraNotes: extraNotesController.text.trim(),
                    ))
                  );
                },
              ),
            ],
          );
        });
  }
}
