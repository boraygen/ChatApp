import 'package:chat_app/screens/authentication/log_tabs.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//cloud firestore 1:25:37
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kThemeColor,
          appBarTheme: AppBarTheme(
            backgroundColor: kThemeColor.withAlpha(60),
            elevation: 0,
          ),
          
        ),
        home: const LogTabs(),
      ),
    );
  }
}


