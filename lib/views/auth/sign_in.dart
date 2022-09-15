import 'package:bus_stop/contollers/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  const LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    return  Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(child: Image.asset('assets/images/image12.png',)),
              ),
              decoration: const BoxDecoration(
                  color: Color(0xffE4181D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffffffff),
              child: Column(
                  children: <Widget>[
                TextFieldContainer(
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.red,
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _passwordController,
                    style: TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: GestureDetector(
                    onTap: () async{
                        final bool isValid = EmailValidator.validate(
                            _emailController.text.trim());
                        if(!isValid){
                          Get.snackbar("Incorrect Email",
                              "Try Again");
                        }else if(_passwordController.text.trim().length < 7){
                           Get.snackbar("Incorrect Password",
                              "Try Again");
                        }else{
                          await _userProvider.signIn(_emailController.text.trim(),
                              _passwordController.text.trim());
                        }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color: Color(0xffE4181D),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Text("Sign in",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Are You New Here?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          widget.toggleView();
                        },
                        child: Text("Create Account",
                          style: TextStyle(
                            fontSize: 20,
                              color: Color(0xffE4181D)),
                        ),
                      ),
                    ],
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Forgot Password?"),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                                final bool isValid = EmailValidator.validate(
                                    _emailController.text.trim());
                                if(!isValid){
                                  showFloatingSnackBar(context, 'A correct Email Is Required To Reset Your Password');
                                  return;
                                }
                              passwordResetDialog(context,_emailController.text.trim());
                            },
                            child: Text("Reset Password",
                              style: TextStyle(
                                fontSize: 16,
                                  color: Colors.green[900]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void showFloatingSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // This will handle the password reset dialog for login_password
   passwordResetDialog(BuildContext context, email) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Forgot Password?"),
        content: RichText(
          text: TextSpan(
              text: "We will send you an email with a password reset link. Press on that link and follow the instructions from there.",
          style: TextStyle(
            fontSize: 18,
              color: Colors.black45)
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text('Yes'),
            onPressed: () {
              _resetPassword(email);
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Password reset email sent",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.9),
                duration: Duration(seconds: 3),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    });
  }

  // Send user an email for password reset
  Future<void> _resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}


