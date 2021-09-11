import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;

//main
Color kMainColor = Colors.orange[500];
Color kAccentColor = Colors.indigo[400];

//dark
Color darkColor = Colors.grey[800].withOpacity(0.6);
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

