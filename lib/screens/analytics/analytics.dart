import 'package:flutter/material.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/components/grey_painter.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: dblue.withOpacity(0.825),
            height: size.height*0.5,
            width: size.width,
            child: CustomPaint(
              painter: GreyPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 22, top: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Overview", style: TextStyle(
                    fontFamily: "OpenSansBold",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),),
                  Text("Analytics", style: TextStyle(
                    fontFamily: "OpenSansBold",
                    fontSize: 31,
                    color: Colors.white,
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
