import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class CheckOutCargo extends StatefulWidget {
  final Client client;
  final String itemDesc;
  final String itemDim;
  final String itemDimCharges;
  final String recName;
  final String recPhone;
  final String extraNotes;

  const CheckOutCargo(
      {Key key,
        this.client,
      this.itemDesc,
      this.itemDim,
      this.recName,
      this.recPhone,
      this.extraNotes,
      this.itemDimCharges})
      : super(key: key);

  @override
  _CheckOutCargoState createState() => _CheckOutCargoState();
}

class _CheckOutCargoState extends State<CheckOutCargo> {
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
        title:
            Text("CONFIRM YOUR ORDER", style: TextStyle(color: Colors.red[900])
                // style: GoogleFonts.roboto(color: Colors.white),
                ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xff2046a1),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            "PARCEL DETAILS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 5),
                        //   child: Divider(
                        //     thickness: 2,
                        //     color: Colors.grey[100],
                        //   ),
                        // ),
                        const Text("ITEM DESCRIPTION",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),
                        RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: widget.itemDesc,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blue[900]))),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("ITEM DIMENSION",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),
                        Text(widget.itemDim,
                            style: TextStyle(
                                fontSize: 17, color: Colors.blue[900])),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("RECEIVER NAME",
                            style:
                                TextStyle(fontSize: 17, color: Colors.black87)),
                        Text(widget.recName,
                            style: TextStyle(
                                fontSize: 15, color: Colors.blue[900])),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("RECEIVER PHONE",
                            style:
                                TextStyle(fontSize: 17, color: Colors.black87)),
                        Text(widget.recPhone,
                            style: TextStyle(
                                fontSize: 15, color: Colors.blue[900])),
                        widget.extraNotes == ""
                            ? Container()
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("EXTRA NOTES",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black87)),
                                  RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          text: widget.extraNotes,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue[900]))),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "TOTAL DELIVERY CHARGES",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: Text(
                              widget.itemDimCharges + " SHS",
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: const Text(
                        "MAKE PAYMENT",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ],
        ),
        // child: Stack(
        //   children: [
        //     Column(
        //       children: [
        //         const SizedBox(height: 10,),
        //         ClipRRect(
        //           borderRadius: BorderRadius.circular(5),
        //           child: Container(
        //             padding: const EdgeInsets.symmetric(vertical: 10),
        //             width: MediaQuery.of(context).size.width,
        //             color: Colors.red[300],
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("PARCEL DETAILS",
        //                     style: TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                         fontSize: 16,
        //                         color: Colors.blue[900]
        //                     )
        //                 ),
        //                 const SizedBox(height: 10,),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 5),
        //                   child: Divider(
        //                     thickness: 2,
        //                     color: Colors.grey[100],),
        //                 ),
        //                 Text("ITEM DESCRIPTION",
        //                     style: TextStyle(
        //                         fontSize: 17,
        //                         color: Colors.yellow[300]
        //                     )
        //                 ),
        //                 RichText(
        //                   textAlign: TextAlign.justify,
        //                     text: TextSpan(
        //                   text: widget.itemDesc,
        //                   style: const TextStyle(
        //                     fontSize: 15,
        //                     color: Colors.white
        //                   )
        //                 )),
        //                 const SizedBox(height: 10,),
        //                 Text("ITEM DIMENSION",
        //                     style: TextStyle(
        //                         fontSize: 17,
        //                         color: Colors.yellow[300]
        //                     )
        //                 ),
        //                 Text(widget.itemDim,
        //                     style: const TextStyle(
        //                         fontSize: 15,
        //                         color: Colors.white
        //                     )
        //                 ),
        //                 const SizedBox(height: 10,),
        //                 Text("RECEIVER NAME",
        //                     style: TextStyle(
        //                         fontSize: 17,
        //                         color: Colors.yellow[300]
        //                     )
        //                 ),
        //                 Text(widget.recName,
        //                     style: const TextStyle(
        //                         fontSize: 15,
        //                         color: Colors.white
        //                     )
        //                 ),
        //                 const SizedBox(height: 10,),
        //                 Text("RECEIVER PHONE",
        //                     style: TextStyle(
        //                         fontSize: 17,
        //                         color: Colors.yellow[300]
        //                     )
        //                 ),
        //                 Text(widget.recPhone,
        //                     style: const TextStyle(
        //                         fontSize: 15,
        //                         color: Colors.white
        //                     )
        //                 ),
        //                 widget.extraNotes == "" ? Container() :
        //                 Column(
        //                   children: [
        //                     const SizedBox(height: 10,),
        //                     Text("EXTRA NOTES",
        //                         style: TextStyle(
        //                             fontSize: 17,
        //                             color: Colors.yellow[300]
        //                         )
        //                     ),
        //                     RichText(
        //                         textAlign: TextAlign.justify,
        //                         text: TextSpan(
        //                         text: widget.extraNotes,
        //                         style: const TextStyle(
        //                             fontSize: 15,
        //                             color: Colors.white
        //                         )
        //                     )),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         const SizedBox(height: 50,),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text("TOTAL DELIVERY CHARGES",
        //                   style: TextStyle(
        //                       fontSize: 17,
        //                       color: Colors.black87
        //                   )
        //               ),
        //               const SizedBox(width: 10,),
        //               Text(widget.itemDimCharges + " SHS",
        //                   style: TextStyle(
        //                       fontSize: 20,
        //                       color: Colors.red[900]
        //                   )
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     Positioned(
        //       bottom: 20,
        //         child: Container(
        //           width: MediaQuery.of(context).size.width,
        //       height: 50,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               ClipRRect(
        //                 borderRadius: BorderRadius.circular(10),
        //                 child: Container(
        //                   width: MediaQuery.of(context).size.width * 0.9,
        //                   height: 50,
        //                   alignment: Alignment.center,
        //                   color: Colors.red[900],
        //                   child: const Text("MAKE PAYMENT",
        //                   style: TextStyle(
        //                     fontSize: 18,
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.bold
        //                   ),
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //     ))
        //   ],
        // ),
      ),
    );
  }
}
