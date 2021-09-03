import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Registerer.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/login.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(body: smallscreen());
  }

 


  Widget smallscreen() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
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
                )
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: Text(
                  "We Welcomes you !!!",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              SizedBox(
                height: 19,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80),
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color:kbgPrimaryColor,width: 1),
                          color: Colors.teal[200].withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)),
                      height: 45,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor,
                                fontSize: 18,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Registerer()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80),
                    child: Container(
                      decoration: BoxDecoration(

                          ///    border: Border.all(color:kbgPrimaryColor,width: 1),
                          color: Colors.teal[200].withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)),
                      height: 45,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "REGISTER",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor,
                                fontSize: 18,
                                letterSpacing: 0),
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
          ),
        ],
      ),
    );
  }
}
