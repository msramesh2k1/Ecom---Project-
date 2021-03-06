import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:universal_html/html.dart';
// import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

class addcategory extends StatefulWidget {
  @override
  _addcategoryState createState() => _addcategoryState();
}

class _addcategoryState extends State<addcategory> {
  bool uploaded = false;
  String imgurl;
  io.File img;
// void uploadFile({@required Function(File file)onSelected}){
//   InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
//   uploadInput.click();
//   uploadInput.onChange.listen((event) {
//     final file = uploadInput.files.first;
//     final reader = FileReader();
//     reader.readAsDataUrl(file);
//     reader.onLoadEnd.listen((event) {
//    onSelected(file);
//     });
//   })
//   ;
// }
// void uploadtoStorage(){
//   uploadFile(onSelected: (file){

// fb.storage().refFromURL("gs://mrandmrs-33fa0.appspot.com")
// .child('image3').put(file);
//   });

// }

  TextEditingController categorycontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp,
                color: kBackgroundColor, size: 12)),
        leadingWidth: 25,
        backgroundColor: Colors.white,
        title: Text(
          "Add Category",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBackgroundColor,
                fontSize: 18,
                letterSpacing: 0),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(color: Colors.black),
                    controller: categorycontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "NAME",
                      labelStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                          letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 17),
                Text(
                  "CHOOSE IMAGE",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: img == null
                      ? GestureDetector(
                          onTap: () async {
                            await ImagePicker()
                                .getImage(source: ImageSource.gallery)
                                .then((image) {
                              setState(() {
                                img = io.File(image.path);
                              });
                            });
                          },
                          child: Container(
                              child: Center(
                                child: Text(
                                  "CHOOSE IMAGE",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38,
                                        fontSize: 10,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: new FileImage(img),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          height: 100,
                          width: 100,
                        ),
                ),
                GestureDetector(
                  onTap: () async {
                    Reference storageref = FirebaseStorage.instance
                        .ref()
                        .child("topof_${categorycontroller.text}.jpg");
                    UploadTask uploadTaskSnapshot =
                        storageref.putFile(img).whenComplete(() async {
                      setState(() async {
                        uploaded = true;
                        imgurl = await storageref.getDownloadURL();
                        print(imgurl);
                        Toast.show("Image Upload Succesfully", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      });
                    });
                  },
                  child: Container(
                      child: Center(
                        child: uploaded
                            ? Text(
                                "DONE",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 10,
                                      letterSpacing: 1),
                                ),
                              )
                            : Text(
                                "UPLOAD",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 10,
                                      letterSpacing: 1),
                                ),
                              ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5)),
                      height: 30,
                      width: 80),
                )
              ],
            ),
            GestureDetector(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("Items")
                      .doc(categorycontroller.text.toString())
                      .set({
                    "image": imgurl,
                    "name": categorycontroller.text.toString(),
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        "UPLOAD",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
