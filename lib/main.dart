import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/contollers/lcoProvider.dart';
import 'package:bus_stop/views/welcome/initial.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BusStopApp());
}

class BusStopApp extends StatelessWidget {
  const BusStopApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationsProvider>.value(
            value: LocationsProvider()),
        ChangeNotifierProvider<UserProvider>.value(
            value: UserProvider()),

        // StreamProvider<Client>.value(
        //   value: AuthService().user,
        // )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bus Stop",
        theme: ThemeData(primarySwatch: Colors.red),
        home: const Initial(),
      ),
    );

    // return StreamProvider<Client>.value(
    //   value: AuthService().user,
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: "Bus Stop",
    //     theme: ThemeData(primarySwatch: Colors.red),
    //     home: const Initial(),
    //   ),
    // );
  }

// @override
// Widget build(BuildContext context) {
//   return StreamProvider<Client>.value(
//     value: AuthService().user,
//     child: MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Bus Stop",
//       theme: ThemeData(primarySwatch: Colors.red),
//       home: const Initial(),
//     ),
//   );
// }
}
