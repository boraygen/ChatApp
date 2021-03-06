import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class LogBigButtonLoading extends StatelessWidget {
  const LogBigButtonLoading({
    Key key,
    this.color,
    this.height
  }) : super(key: key);

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: SizedBox(
        width: 54,
        height: height ?? 54,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: CircularProgressIndicator(
              color: color,
            ),
          ),
        )
      ),
    );
  }
}