import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/components/painter.dart';
import 'package:rememory/screens/contacts/edit_contact.dart';

import '../home.dart';

class FaceDetected extends StatefulWidget {
  @override
  _FaceDetectedState createState() => _FaceDetectedState();
}

class _FaceDetectedState extends State<FaceDetected> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: green1,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Positioned(
            bottom: size.height*0.28,
            left: size.width*0.1,
            child: Container(
              height: size.height*0.45,
              width: size.width*0.8,
              child: Image(
                image: AssetImage("assets/bill_gates.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: size.height*0.135,
            left: size.width*0.1,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditContact()));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.6,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ]
                      )
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "VIEW CONTACT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(0)));
                },
              ),
            ),
          ),
          Positioned(
            top: size.height*0.15,
            left: size.width*0.16,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("REMEMBER", style: TextStyle(
                    fontFamily: "OpenSansBold",
                    fontSize: 18,
                    color: titleText,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("Whos Important", style: TextStyle(
                    fontFamily: "OpenSansBold",
                    fontSize: 31,
                    color: titleText,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
