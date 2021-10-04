import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;



//booleans
bool registerSuccessful = true;

//setting
// void changeMode()
// {
//   if(kDarkMode)
//   {
//     kThemeColor = brightColor;
//     kPrimaryTextColor = brightPrimaryTextColor;
//     kSecondaryTextColor = brightSecondaryTextColor;
//     kModeIcon = brightModeIcon;
//   }
//   else
//   {
//     kThemeColor = darkColor;
//     kPrimaryTextColor = darkPrimaryTextColor;
//     kSecondaryTextColor = darkSecondaryTextColor;
//     kModeIcon = darkModeIcon;
//   }
//   kDarkMode = !kDarkMode;
// }

bool validateBeforeLog(BuildContext context, String email, String pw1, String pw2)
{
  bool validation = true;
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  if(emailValid)
  {
    if(pw1.length < 6)
    {

      customSnackBar(context: context, type: -1, text: "Password must be at least 6 characters long!");

      validation = false;
    }
    if(pw2 != null)
    {
      if(pw1 != pw2)
      {
        customSnackBar(context: context, type: -1, text: "Password don't match!");

        validation = false;
      }
    }
  }
  else
  {
    customSnackBar(context: context, type: -1, text: "Invalid email!");
    validation = false;
  }

  return validation;
}

showAreYouSureDialog({BuildContext context, String title, String question, String actionButtonText, Function actionButtonOnPressed, Widget optional})
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(
            top: 16,
            left: 20,
            right: 20,
            bottom: 1
          ),
          elevation: 4,
          titleTextStyle: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16.5,
            fontWeight: FontWeight.bold,
          ),
          title: Text(
            title,
          ),
          content: SizedBox(
            height: 80,
            child: Column(
              children: [
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 15
                  ),
                ),
                optional ?? const SizedBox(),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(actionButtonText, style: TextStyle(color: kMainColor),),
              onPressed: actionButtonOnPressed
            ),
            TextButton(
              child: Text("Cancel", style: TextStyle(color: kMainColor),),
              onPressed:  () 
              {
                Navigator.pop(context);
              },
            ),
          ]
        );
      },
    );
  }