import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rememory/components/LoadingAnimation.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/onboarding/signin.dart';
import 'package:rememory/screens/dashboard/quiz/quiz_screen.dart';
import 'package:rememory/services/auth.dart';
import 'package:rememory/services/database.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rememory/services/helperfunctions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'face_id.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

String _username = '';

class _DashboardState extends State<Dashboard> {
  QuerySnapshot searchSnapshot;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserInfo() async {
    _username = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
    databaseMethods.getQuizzes(_username).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  Widget quizList() {
    return searchSnapshot != null
        ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return QuizTile(
            title: searchSnapshot.docs[index].data()["quiz name"],
            scoretitle: searchSnapshot.docs[index].data()["score"],
            score: searchSnapshot.docs[index].data()["int"],
            date: searchSnapshot.docs[index].data()["date"],
            context: context,
          );
        })
        : Loading();
  }

  Widget QuizTile({String title, String scoretitle, int score, String date, BuildContext context}){
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(
                      color: titleText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(date, style: TextStyle(
                      color: secondaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(scoretitle, style: TextStyle(
                      color: titleText,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(height: 5,),
                    StepProgressIndicator(
                      fallbackLength: 150,
                      totalSteps: 5,
                      currentStep: score,
                      size: 8,
                      padding: 0,
                      roundedEdges: Radius.circular(10),
                      selectedColor: dblue,
                      unselectedColor: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 1,
              color: secondaryText,
              width: size.width*0.94,
            ),
          ),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Dashboard", style: TextStyle(
                    fontFamily: "OpenSansBold",
                    fontSize: 31,
                    color: titleText,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
            Icon(Icons.arrow_left, color: Colors.transparent,),
            Container(
              padding: EdgeInsets.only(left: 2),
              decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: (){
                  authMethods.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(MdiIcons.logout, color: titleText, size: 22,),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FaceID()));
                    },
                    child: Container(
                      width: size.width*0.425,
                      height: size.width*0.5,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Color(0xff3bb2b8).withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(2, 7),
                        ), ],
                        borderRadius: BorderRadius.circular(17),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff42e695),
                              Color(0xff3bb2b8),
                            ],
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 12),
                        child: Image(
                          image: AssetImage('assets/face-id.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    },
                    child: Container(
                      width: size.width*0.425,
                      height: size.width*0.5,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Color(0xffff7676).withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(2, 7),
                        ), ],
                        borderRadius: BorderRadius.circular(17),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xfff54ea2),
                            Color(0xffff7676),
                          ],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/quiz.png'),
                              fit: BoxFit.contain,
                            )),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height*0.045,),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Text("Review Quizes", style: TextStyle(
                  color: titleText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),

            SizedBox(height: size.height*0.025,),

            Container(
              height: size.height*0.395,
                child: quizList()
            ),
            //QuizTile("Quiz 1", "4/5", 4, context),
            //QuizTile("Quiz 2", "2/5", 2, context),

          ],
        ),
      ),
    );
  }
}