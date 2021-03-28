import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rememory/components/LoadingAnimation.dart';
import 'package:rememory/components/colors.dart';
import 'package:rememory/services/database.dart';
import 'package:rememory/services/helperfunctions.dart';

import 'add_contact.dart';
import 'edit_contact.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

String _username = '';

class _ContactsState extends State<Contacts> {
  QuerySnapshot searchSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserInfo() async {
    _username = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
    databaseMethods.getContacts(_username).then((val) {
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

  Widget userList() {
    return searchSnapshot != null
        ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ContactTile(
            fname: searchSnapshot.docs[index].data()["first name"],
            lname: searchSnapshot.docs[index].data()["last name"],
            relation: searchSnapshot.docs[index].data()["relation"],
            image: searchSnapshot.docs[index].data()["image"],
            context: context,
          );
        })
        : Loading();
  }

  Widget ContactTile({String fname, String lname, String relation, String image, BuildContext context}){
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditContact()));
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right:25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    margin: EdgeInsets.only(top: 7, left: 5, bottom: 7),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    width: size.width*0.68,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$fname " + "$lname", style: TextStyle(
                              color: titleText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text(relation, style: TextStyle(
                              color: secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                          color: secondaryText.withOpacity(0.6),
                          size: 22,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 1,
                color: secondaryText.withOpacity(.7),
                width: size.width*0.75,
              ),
            ),
          ],
        ),
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
                  child: Text("Contacts", style: TextStyle(
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
                },
                icon: Icon(Icons.search, color: titleText, size: 24,),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: size.width*0.375, bottom: 5),
        child: FloatingActionButton(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddContact()));
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
              child: Icon(Icons.add, color: Colors.white, size: 30,)
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: userList(),
      ),
    );
  }
}