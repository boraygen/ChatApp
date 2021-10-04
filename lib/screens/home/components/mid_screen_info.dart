import 'package:flutter/material.dart';

class MidScreenInfo extends StatelessWidget {
  const MidScreenInfo({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center( // Add a friend to start chatting
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height > size.width ? 200 : 80,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}