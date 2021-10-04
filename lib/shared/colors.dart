import 'package:flutter/material.dart';

//main
Color kMainColor = Colors.orange[500];
Color kAccentColor = Colors.indigo[400];
Color kAppBarColor = Colors.grey[800].withOpacity(0.68).withRed(50).withGreen(60).withAlpha(150);
Color kContainerColor = Colors.grey[800].withOpacity(0.68).withRed(58).withGreen(60).withAlpha(60);

//dark
Color darkColor = Colors.grey[800].withOpacity(0.68).withRed(58).withGreen(60);
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
Color kAccentTextColor1 = kPrimaryTextColor.withOpacity(0.8);
Color kAccentTextColor2 = kPrimaryTextColor.withOpacity(0.6);
Color kSelectedTileColor = kAccentColor.withOpacity(0.2);
Icon kModeIcon = darkModeIcon;
