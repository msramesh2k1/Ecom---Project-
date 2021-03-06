import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/MainScreen.dart';
import 'package:mr_and_mrs/Orders.dart';
import 'package:mr_and_mrs/constants.dart';

import 'Admin.dart';
import 'CartPage.dart';
import '_address.dart';

class userScren extends StatefulWidget {
  @override
  _userScrenState createState() => _userScrenState();
}

class _userScrenState extends State<userScren> {
  int cartno = 0;

  int cartvalueno() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        cartno = querySnapshot.docs.length;
      });
    });
    return cartno;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // actionsIconTheme: IconThemeData(color: Colors.white),
        actions: [
          // GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           new MaterialPageRoute(builder: (BuildContext context) {
          //         return userScren();
          //       }));
          //     },
          //     child: Icon(Icons.account_circle_outlined, size: 20)),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context)
          //         .push(new MaterialPageRoute(builder: (BuildContext context) {
          //       return Search();
          //     }));
          //   },
          //   child: Icon(Icons.search, size: 20),
          // ),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           new MaterialPageRoute(builder: (BuildContext context) {
          //         return userScren();
          //       }));
          //     },
          //     child: Icon(Icons.favorite_outline_rounded, size: 20)),
          Column(
            children: [
              SizedBox(
                height: 3,
              ),
              GestureDetector(
                onTap: () {},
                child: Stack(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return cart();
                        }));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 20,
                      )),
                  Positioned(
                    right: 7,
                    top: 7,
                    child: CircleAvatar(
                      child: Text(
                        cartvalueno().toString(),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.red[900],
                      radius: 8,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
        leading: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,
                    color: kBackgroundColor, size: 15)),
          ],
        ),
        leadingWidth: 25,
        title: Text(
          "User Settings",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBackgroundColor,
                fontSize: 18,
                letterSpacing: 1),
          ),
        ),

        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                    // color:Colors.blueGrey[100]
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   width: 12,
                          // ),
                          Text(
                            "Welcome  " +
                                MRANDMRS.sharedprefs.getString("name") +
                                " ,",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                  letterSpacing: 0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   width: 12,
                            // ),
                            Text(
                              "Email :  " +
                                  MRANDMRS.sharedprefs.getString("email"),
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 20,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SizedBox(
            //   height: 15,
            // ),
            // Divider(color: Colors.black),
            // SizedBox(
            //   height: 15,
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 12,
            //     ),
            //     Text(
            //       "ACCOUNT SETTINGS : ",
            //       style: GoogleFonts.lato(
            //         textStyle: TextStyle(
            //             fontWeight: FontWeight.w800,
            //             color: Colors.black,
            //             fontSize: 13,
            //             letterSpacing: 1),
            //       ),
            //     ),
            //   ],
            // ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal[50].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => Orders());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "My Orders",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => Admin());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "##  --  ADMIN  --  ##",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // // Divider(color: Colors.black),

                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => maineraddress());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Address",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Route route = MaterialPageRoute(
                                builder: (context) => MainScreen());
                            Navigator.pushReplacement(context, route);
                            MRANDMRS.sharedprefs.remove("uid");
                          },
                          child: Text(
                            "Sign Out",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
