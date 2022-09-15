import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/homeType.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auhenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoading) {
      return Loading();
    } else {
      if (userProvider.client == null) {
        return AuthWrapper();
      } else {
        return HomeType(
          client: userProvider.client,
        );
      }
    }
  }
}
