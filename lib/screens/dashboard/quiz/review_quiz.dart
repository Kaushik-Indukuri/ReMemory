import 'package:flutter/material.dart';
import 'package:rememory/components/colors.dart';

import '../../home.dart';

class ReviewQuiz extends StatefulWidget {
  @override
  _ReviewQuizState createState() => _ReviewQuizState();
}

class _ReviewQuizState extends State<ReviewQuiz> {

  Color getTheRightColor(int index) {
      if (index == 0) {
        return kGreenColor;
      } else if (index == 1) {
        return kRedColor;
      }
    return kGrayColor;
  }


  IconData getTheRightIcon(int index) {
    return getTheRightColor(index) == kRedColor ? Icons.close : Icons.done;
  }


  Widget qtOption (String title, int index){
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: getTheRightColor(index)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: getTheRightColor(index), fontSize: 16),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: getTheRightColor(index) == kGrayColor
                  ? Colors.transparent
                  : getTheRightColor(index),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: getTheRightColor(index)),
            ),
            child: getTheRightColor(index) == kGrayColor
                ? null
                : Icon(getTheRightIcon(index), size: 16),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leadingWidth: size.width*0.2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: titleText,),
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(0)),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
