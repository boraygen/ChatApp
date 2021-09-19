import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;

//main
Color kMainColor = Colors.orange[500];
Color kAccentColor = Colors.indigo[400];

//dark
Color darkColor = Colors.grey[800].withOpacity(0.5);
Color darkPrimaryTextColor = Colors.white;
Color darkSecondaryTextColor = Colors.black87;
const darkModeIcon = Icon(Icons.dark_mode_outlined);

//bright
Color brightColor = Colors.white.withOpacity(0.84);
Color brightPrimaryTextColor = Colors.black87;
Color brightSecondaryTextColor = Colors.white;
const brightModeIcon = Icon(Icons.light_mode_outlined);

//type
bool kDarkMode = true;
Color kThemeColor = darkColor;
Color kPrimaryTextColor = darkPrimaryTextColor;
Color kSecondaryTextColor = darkSecondaryTextColor;
Icon kModeIcon = darkModeIcon;

//booleans
bool registerSuccessful = true;

//setting
void changeMode()
{
  if(kDarkMode)
  {
    kThemeColor = brightColor;
    kPrimaryTextColor = brightPrimaryTextColor;
    kSecondaryTextColor = brightSecondaryTextColor;
    kModeIcon = brightModeIcon;
  }
  else
  {
    kThemeColor = darkColor;
    kPrimaryTextColor = darkPrimaryTextColor;
    kSecondaryTextColor = darkSecondaryTextColor;
    kModeIcon = darkModeIcon;
  }
  kDarkMode = !kDarkMode;
}

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

