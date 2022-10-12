import 'package:bus_stop/contollers/authController.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String countryCde = "";
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    return
         Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Center(
                              child: Image.asset(
                            'assets/images/image11.png',
                          )),
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xffE4181D),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                color: Color(0xffffffff),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    children: <Widget>[
                                  TextFieldContainer(
                                    child: TextField(
                                      controller: _usernameController,
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                        hintText: "Username",
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.red,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    child: TextField(
                                      controller: _emailController,
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
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
                                      controller: _phoneController,
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                        prefixIcon: Container(
                                          width: 120,
                                          child: Row(
                                            children: [
                                              Icon(Icons.phone,
                                              color: Colors.red,
                                                size: 20,
                                              ),
                                              Container(
                                                width: 100,
                                                child: CountryCodePicker(
                                                  initialSelection: "ug",
                                                  onInit: (code) {
                                                    countryCde = code.dialCode;
                                                  },
                                                  onChanged: (code) {
                                                    countryCde = code.dialCode;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: "Phone Number(7xx...)",
                                        hintStyle: TextStyle(fontSize: 13),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    child: TextField(
                                      controller: _passwordController1,
                                      cursorColor: Colors.red,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(
                                          Icons.lock,
                                          color: Colors.red,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                      TextFieldContainer(
                                        child: TextField(
                                          controller: _passwordController2,
                                          cursorColor: Colors.red,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Repeat Password",
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.red,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                    padding: const EdgeInsets.only(left: 30,right: 30,bottom: 5,top: 5),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final bool isValid = EmailValidator.validate(
                                            _emailController.text.trim());
                                        if(_usernameController.text.trim().length < 3){
                                          Get.snackbar("Incorrect/Short Username",
                                              "Try Again");
                                        }else if(!isValid){
                                          Get.snackbar("Incorrect Email",
                                              "Try Again");
                                        } else if((countryCde + _phoneController.text.trim()).length < 10 ){
                                          Get.snackbar("Incorrect Phone Number",
                                              "Try Again");
                                        } else if(_passwordController1.text.trim().length < 7){
                                          Get.snackbar("Incorrect Password",
                                              "Try Again");
                                        } else if (_passwordController1.text.trim() != _passwordController2.text.trim()){
                                          Get.snackbar("Passwords Don't Match",
                                              "Try Again");
                                        } else{
                                          await _userProvider.registerClient(
                                            email: _emailController.text.trim(),
                                            username: _usernameController.text.trim(),
                                            phoneNumber: countryCde+_phoneController.text.trim(),
                                            password: _passwordController1.text.trim(),
                                          );
                                        }
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: Color(0xffE4181D),
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          child: const Text("Create Account",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Already Having An Account?"),
                                        SizedBox(width: 5,),
                                        GestureDetector(
                                          onTap: (){
                                            widget.toggleView();
                                          },
                                          child: Text("Sign In",
                                            style: TextStyle(color: Color(0xffE4181D)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
