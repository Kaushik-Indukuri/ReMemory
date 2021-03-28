import 'package:rememory/components/FadeAnimation.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/onboarding/signin.dart';
import 'package:rememory/onboarding/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: dblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 34),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "ReMemory, a free application to remember what is important ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: secondaryText, fontSize: 18),
                      )),
                ],
              ),
              FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 2.75,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage('assets/welcome-pic.png'),
                          fit: BoxFit.cover,
                        )),
                  )),
              FadeAnimation(1.5,
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: size.width * 0.9,
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
                        "GET STARTED",
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
              //SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}