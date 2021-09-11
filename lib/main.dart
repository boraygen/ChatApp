import 'package:chat_app/screens/connection/log_page_view.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  ThemeData _darkTheme()
  {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: kThemeColor,
      primaryColor: kMainColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle( // appBar text style
          color: kMainColor,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
      child: MaterialApp(
        theme: _darkTheme(),
        home: const LogPageView(),
      ),
    );
  }
}


