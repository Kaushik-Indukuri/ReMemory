import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rememory/components/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rememory/services/helperfunctions.dart';

import '../home.dart';

class AddContact extends StatefulWidget {

  @override
  _AddContactState createState() => _AddContactState();
}

String _username = '';

class _AddContactState extends State<AddContact> {
  File _image;
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController relation = new TextEditingController();
  TextEditingController memories = new TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('contacts');

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
    Size size = MediaQuery.of(context).size;

    Future getImage() async{
      var image = await ImagePicker().getImage(source: ImageSource.gallery);
      setState((){
        _image = File(image.path);
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image);
      uploadTask.whenComplete(() {
        setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
        });
      }).catchError((onError) {
        print(onError);
      });
      return url;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: titleText, size: 20,),
          ),
        ),
        title: Text("New Contact", style: TextStyle(
          color: titleText,
        ),),
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: size.width*0.5,
                  child: CircleAvatar(
                    radius: 75,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 160,
                        width: 160,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: _image!=null ? Image.file(_image, fit: BoxFit.cover,)
                            : Image(
                          image: AssetImage('assets/new-contact.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: background,
                          shape: BoxShape.circle
                      ),
                      child: IconButton(
                        onPressed: () async{
                         getImage();
                        },
                        icon: Icon(Icons.camera_alt_outlined, color: titleText, size: 25,),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: firstname,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "First Name"
                ),
              ),
            ),
            SizedBox(height: size.height*0.03,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: lastname,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Last Name"
                ),
              ),
            ),
            SizedBox(height: size.height*0.03,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: relation,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Relation (be specific)"
                ),
              ),
            ),
            SizedBox(height: size.height*0.03,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: memories,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Important Memories"
                ),
              ),
            ),
            SizedBox(height: size.height*0.055,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  //uploadPic(context);
                  ref.add({
                    'user': _username,
                    'first name': firstname.text,
                    'last name': lastname.text,
                    'relation': relation.text,
                    'memories': memories.text,
                    'image': "http://www.gstatic.com/tv/thumb/persons/614/614_v9_bc.jpg"
                  }).whenComplete(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home(2)),
                        (Route<dynamic> route) => false,
                  ));
                  setState(() {});
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
                    "SAVE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
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
