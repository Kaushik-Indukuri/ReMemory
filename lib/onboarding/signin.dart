import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rememory/components/FadeAnimation.dart';
import 'package:rememory/components/LoadingAnimation.dart';
import 'package:rememory/onboarding/signup.dart';
import 'package:rememory/screens/home.dart';
import 'package:rememory/services/auth.dart';
import 'package:rememory/services/database.dart';
import 'package:rememory/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:rememory/components/background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot snapshotUserInfo;

  signMeIn() async{

    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
        print("${snapshotUserInfo.docs[0].data()["name"]}");
      });

      setState(() {
        loading = true;
      });

      authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
        }
      });

      dynamic result = await authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text);

      if(result == null){
        setState(() {
          error = 'Your email or password seems to be incorrect';
          loading = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(0)),
              (Route<dynamic> route) => false,
        );
        print('signed in');
      }
    }
  }

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool loading = false;
  String error = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

            SizedBox(height: size.height * 0.03),

            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: emailTextEditingController,
                      obscureText: false,
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter a valid email";
                      },
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: passwordTextEditingController,
                      validator: (val) {
                        return val.length > 6 ? null : "Enter a password with 6+ characters";
                      },
                      decoration: InputDecoration(
                          labelText: "Password"
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0XFF2661FA)
                ),
              ),
            ),

            Text(error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15.0,
              ),
            ),

            SizedBox(height: size.height * 0.015),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  signMeIn();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
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
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
                },
                child: Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}