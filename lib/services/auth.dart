import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  // firebase user to user model
  UserModel userToUserModel(User user)
  {
    return UserModel(uid: user.uid);
  }

  // sign in email
  Future signInWithEmailAndPw(BuildContext context, String email, String password) async
  {
    try
    {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userToUserModel(user);
    }
    catch(e)
    {
      customSnackBar(context: context, type: -1, text: "Error!");
      print(e.toString());
      return null;
    }
  }

  // sign up email
  Future signUpWithEmailAndPw(BuildContext context, String email, String password) async
  {
    try 
    {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userToUserModel(user);
    } 
    catch (e) 
    {
      print(e.toString());
      if(e.toString().contains("email-already-in-use"))
      {
        customSnackBar(context: context, type: -1, text: "Email is already in use!");
      }
      else
      {
        customSnackBar(context: context, type: -1, text: "Unknown error.");
      }
      return null;
    }
  }

  // reset password
  Future resetPassword(String email) async
  {
    try 
    {
      return await _auth.sendPasswordResetEmail(email: email);
    } 
    catch (e) 
    {
      print(e.toString());   
      return null;
    }
  }

  // sign out
  Future signOut() async
  {
    try 
    {
      return await _auth.signOut();
    } 
    catch (e) 
    {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async
  {
    //UserCredential result = await 
  }
}