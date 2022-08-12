import 'package:bus_stop/views/auth/register.dart';
import 'package:bus_stop/views/auth/sign_in.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showSignIn = true;

  void toggleSignIn() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? LoginScreen(toggleView: toggleSignIn)
        : RegisterScreen(toggleView: toggleSignIn);
  }
}
