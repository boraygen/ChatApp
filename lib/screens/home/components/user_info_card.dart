import 'dart:math';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({ Key key, this.user }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Container(
      // color: Colors.red,
      height: 255,
      width: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(  // image
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(
                  "assets/dummyLogos/dummyChatLogo" "${random.nextInt(8)}" ".png",
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                  ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(  // username
                  children: [
                    Text(
                      "Username: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: kAccentTextColor2,
                      ),
                    ),
                    SizedBox(
                      width: 178,
                      child: Text(
                        "${user.username}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2,),
                Row(  // id
                  children: [
                    Text(
                      "User ID: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: kAccentTextColor2
                      ),
                    ),
                    Text(
                      "#${user.usernameId}",
                      style: const TextStyle(
                        fontSize: 15.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2,),
                SizedBox( // status
                  width: 239,
                  height: 35,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Status: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: kAccentTextColor2
                      ),
                      children: [
                        TextSpan(
                          text: "\"${user.status}\"",
                          style: TextStyle(
                            fontSize: 15,
                            color: kPrimaryTextColor
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  )
                ),
              ],
            ),
          ),
          Padding(  // close button
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Text("Close", style: TextStyle(color: kMainColor),),
                onPressed:  () 
                {
                  Navigator.pop(context);
                },
              )
            ),
          )
        ],
      ),
    );
  }
}