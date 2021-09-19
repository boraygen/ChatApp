import 'package:chat_app/screens/authentication/log_tabs.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final Auth auth;

  @override
  Widget build(BuildContext context) {
    return IconButton(
     icon: const Icon(Icons.exit_to_app_rounded),
      onPressed: () 
      {
        auth.signOut();
        Navigator.pushReplacement(context, 
          MaterialPageRoute(
            builder: (context) => const LogTabs(),
          )
        );
      }
    );
  }
}