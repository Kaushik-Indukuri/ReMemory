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
      margin: EdgeInsets.only(top: 20),
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


  Widget qtCard(String question, String op1, String op2, String op3, String op4,
      int ind1, int ind2, int ind3, int ind4) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 10),
      padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding,
          top: kDefaultPadding, bottom: 30),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.grey,
          blurRadius: 10,
          offset: Offset(0,1),
        ),],
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(question,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          qtOption(op1, ind1),
          qtOption(op2, ind2),
          qtOption(op3, ind3),
          qtOption(op4, ind4),
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
            qtCard("Who is your high school friend?", "Jungkook Jeon",
                "Nitin Indukuri", "Jin Kim", "Bill Gates", 0, 3, 1, 3),
            qtCard("Who did you have a this memory with: Going to concert?",
                "Yoon-gi Min", "Bill Gates", "Jin Kim", "Bill Gates",
                0, 3, 1, 3)

          ],
        ),
      ),
    );
  }
}
