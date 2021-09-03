import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/ErrorAlert.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/HomScreen.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/login.dart';

class Registerer extends StatefulWidget {
  @override
  _RegistererState createState() => new _RegistererState();
}

class _RegistererState extends State<Registerer> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _password = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController resetemailtexteditingcontroller =
      new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController namecontroller = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _password = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(resizeToAvoidBottomInset: false, body: smallscreen());
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
                              child: TextField(
                                style: TextStyle(color: kBackgroundColor),
                                textCapitalization: TextCapitalization.words,
                                cursorColor: kBackgroundColor,
                                controller: namecontroller,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Name',
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
                                    labelText: 'Password',
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
                                obscureText: !_password,
                                cursorColor: kBackgroundColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                emailcontroller.text.isNotEmpty &&
                                        passwordcontroller.text.isNotEmpty
                                    ? _Registerform()
                                    : showDialog(
                                        context: context,
                                        builder: (c) {
                                          return ErrorAlertDialog(
                                              message: "SOME FIELDS ARE EMPTY");
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
                                  //  width:20,

                                  child: Center(
                                    child: Text(
                                      "REGISTER",
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
                        MaterialPageRoute(builder: (context) => Login());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already an User ? ",
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
                          "Login",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kBackgroundColor,
                                fontSize: 17,
                                letterSpacing: 1),
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

  Future<void> _Registerform() async {
    User firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((auth) {
      firebaseUser = auth.user;
    });
    print("uid = " + firebaseUser.uid);
    Fluttertoast.showToast(
      msg: 'Registered Successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );

    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set({
        "uid": firebaseUser.uid,
        "email": firebaseUser.email,
        "name": namecontroller.text.trim(),
      });
      MRANDMRS.sharedprefs.setString("uid", firebaseUser.uid);
      MRANDMRS.sharedprefs.setString("email", firebaseUser.email);
      MRANDMRS.sharedprefs.setString("name", namecontroller.text).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }
}
