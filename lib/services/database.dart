import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String email) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: email)
        .get();
  }


  Future<void> uploadUserInfo(userData) async {
    FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }


  getContacts(String username) async{
    return await FirebaseFirestore.instance.collection("contacts")
        .where("user", isEqualTo: username)
        .get();
  }

  getQuizzes(String username) async{
    return await FirebaseFirestore.instance.collection("quizzes")
        .where("user", isEqualTo: username)
        .get();
  }


}