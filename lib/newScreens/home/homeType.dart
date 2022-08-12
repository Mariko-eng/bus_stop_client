import 'package:bus_stop/newScreens/home/homeCargo.dart';
import 'package:bus_stop/newScreens/home/homeTravel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeType extends StatefulWidget {
  final String userID;

  const HomeType({this.userID, Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<HomeType> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                    color: Color(0xffE4181D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Image.asset(
                  'assets/images/image11.png',
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Book Your Next Trip Bus Today",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "We make the process of international bus "
                                "travel fast and without all the hassle",
                            style: TextStyle(color: Color(0xffE4181D)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeCargo(
                                  userID: widget.userID,
                                )));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: const Color(0xffE4181D))),
                          child: const Text(
                            "Cargo",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xffE4181D)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeTravel(
                                  userID: widget.userID,
                                )));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xffE4181D),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: const Text(
                            "Travel",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
