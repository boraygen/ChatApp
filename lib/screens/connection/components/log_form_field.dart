import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class LogFormField extends StatelessWidget {
  const LogFormField({
    Key key,
    @required this.text,
    @required this.onChanged,
    @required this.isPw,
  }) : super(key: key);

  final String text;
  final Function onChanged;
  final bool isPw;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPw,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.4),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kMainColor),
        ),
      ),
      onChanged: onChanged,   
    );
  }
}