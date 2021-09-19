import 'package:cloud_firestore/cloud_firestore.dart';

class Database
{
  final String uid;
  Database({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  getUserByUsername(String username)
  {

  }

  Future setUsernameAndId(String username, int usernameId) async
  {
    return await userCollection.doc(uid).set(
      {
        "username": username,
        "usernameId": usernameId,
      }
    );
  }

}