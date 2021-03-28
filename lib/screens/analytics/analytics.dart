import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/components/grey_painter.dart';

import 'graph_funct.dart';

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
          Positioned(
            top: size.height*0.185,
            left: 20,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(bottom: 7),
                height: 225,
                width: size.width-40,
                decoration: BoxDecoration(
                  color: Color(0xff002047),
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                        color: titleText,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                  ],
                ),
                child: GraphFunction(),
              ),
            ),
          ),
          Positioned(
            top: size.height*0.525,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("REVIEW", style: TextStyle(
                    color: titleText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 12.0,
                    animation: true,
                    backgroundColor: Colors.white,
                    percent: 0.7,
                    center: Text(
                      "Hi YouTube!",
                    ),
                    progressColor: Colors.green,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
