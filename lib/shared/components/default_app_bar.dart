import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

AppBar defaultAppBar({String title, PreferredSizeWidget bottom, List<Widget> actions }) {
    return AppBar(
      toolbarHeight: bottom == null ? 50 : 38,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.only(
          top: bottom == null ? 0 : 8.0,
          bottom: bottom == null ? 2 : 0,
        ),
        child: Text(
          title ?? "Chat App",
          style: TextStyle( // appBar text style
            color: kMainColor,
            fontStyle: FontStyle.italic,
            fontWeight: title == null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }