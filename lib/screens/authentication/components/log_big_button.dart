import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class LogBigButton extends StatelessWidget {
  const LogBigButton({
    Key key, this.text, this.press, this.buttonColor, this.textColor,
  }) : super(key: key);

  final String text;
  final Function press;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: GestureDetector(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.only(bottom: 2),
          alignment: Alignment.center,
          width: size.width < size.height ? size.width : size.height,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: buttonColor,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

