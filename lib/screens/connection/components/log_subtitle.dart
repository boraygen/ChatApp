import 'package:flutter/material.dart';

class LogSubtitle extends StatelessWidget {
  const LogSubtitle({
    Key key, this.subtitle
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}