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
            top: size.height*0.54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text("REVIEW", style: TextStyle(
                    color: titleText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(height:25,),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 12.0,
                            animation: true,
                            backgroundColor: Colors.grey[300],
                            percent: 0.8,
                            center: Text("Face", style: TextStyle(
                              color: titleText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),),
                            progressColor: Color(0xffff7676),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("4/5", style: TextStyle(
                              color: titleText,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 12.0,
                            animation: true,
                            backgroundColor: Colors.grey[300],
                            percent: 0.33,
                            center: Text("Memories", style: TextStyle(
                              color: titleText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),),
                            progressColor: Colors.lightBlueAccent,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("1/3", style: TextStyle(
                              color: titleText,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 12.0,
                            animation: true,
                            backgroundColor: Colors.grey[300],
                            percent: 0.7,
                            center: Text("Relation", style: TextStyle(
                              color: titleText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),),
                            progressColor: green1,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("5/7", style: TextStyle(
                              color: titleText,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
