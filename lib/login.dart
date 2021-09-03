import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/ErrorAlert.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/HomScreen.dart';
import 'package:mr_and_mrs/Registerer.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/forgotpassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _password = true;
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController resetemailtexteditingcontroller =
      new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();

//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _password = false;
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(resizeToAvoidBottomInset: false, body: smallscreen());
  }

  Widget smallscreen() {
    return Container(
      color: Colors.white,
      
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 75.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mr & Mrs",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                        fontSize: 30,
                        letterSpacing: 0),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Design Wood Works",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 18,
                        letterSpacing: 0),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 1,
                  color: kPrimaryColor,
                  width: 80,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal[200].withOpacity(0.4)),
                      padding:
                          EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.teal[50]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                style: TextStyle(color: kBackgroundColor),
                                cursorColor: kBackgroundColor,
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.normal,
                                        color: kBackgroundColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.teal[50]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                style: TextStyle(color: kBackgroundColor),
                                controller: passwordcontroller,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _password
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: kBackgroundColor),
                                      onPressed: () {
                                        setState(() {
                                          _password = !_password;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.normal,
                                        color: kBackgroundColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                obscureText: !_password,
                                cursorColor: kBackgroundColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.0),
                          Container(
                            alignment: Alignment(1.0, 0.0),
                            padding: EdgeInsets.only(top: 10.0, left: 20.0),
                            child: InkWell(
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => ForgotPassword());
                                Navigator.push(context, route);
                              },
                              child: Text(
                                "Forget password",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 14,
                                      letterSpacing: 0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                emailcontroller.text.isNotEmpty &&
                                        passwordcontroller.text.isNotEmpty
                                    ? _loginform()
                                    : showDialog(
                                        context: context,
                                        builder: (c) {
                                          return ErrorAlertDialog(
                                              message:
                                                  "Provide Email and Password");
                                        });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 60.0, right: 60),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  height: 45,
                            

                                  child: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12,
                                            letterSpacing: 3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => Registerer());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "New User ? ",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kCaptionColor,
                                fontSize: 16,
                                letterSpacing: 0),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Register",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kBackgroundColor,
                                fontSize: 16,
                                letterSpacing: 0),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginform() async {
    User firebaseUser;
    await auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((authUser) {
      print("hypo");
      Fluttertoast.showToast(
        msg: 'Logged In',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,

        backgroundColor: Colors.black,
        textColor: Colors.white,
       
      );
      firebaseUser = authUser.user;
      print(firebaseUser.uid);
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  readData(User fUser) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
     
      await MRANDMRS.sharedprefs.setString("uid", dataSnapshot.data()["uid"]);
      await MRANDMRS.sharedprefs
          .setString("email", dataSnapshot.data()["email"]);
      await MRANDMRS.sharedprefs.setString("name", dataSnapshot.data()["name"]);
    });
  }
}
