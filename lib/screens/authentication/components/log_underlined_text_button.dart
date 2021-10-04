import 'package:chat_app/shared/colors.dart';
import 'package:flutter/material.dart';

class LogUnderlinedTextButton extends StatelessWidget {
  const LogUnderlinedTextButton({
    Key key, this.text, this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: kPrimaryTextColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}