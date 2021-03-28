import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/services/helperfunctions.dart';
import '../../home.dart';
import 'models/question_controller.dart';

class ScoreScreen extends StatefulWidget {

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

String _username = '';

class _ScoreScreenState extends State<ScoreScreen> {

  CollectionReference ref = FirebaseFirestore.instance.collection('quizzes');

  getUserInfo() async{
    _username = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 15,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: titleText,),
                  onPressed: (){
                    ref.add({
                      'user': _username,
                      'quiz name': "Quiz 3",
                      'score': "2/5",
                      'int': 2,
                      'date': "3. 27. 2021",
                    }).whenComplete(() => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home(0)),
                          (Route<dynamic> route) => false,
                    ));
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: titleText),
              ),
              Spacer(),
              Text(
                "2/${_qnController.questions.length}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: titleText),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}