import 'dart:math';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/authentication/components/log_form_field.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendFriendRequestDialog extends StatefulWidget {
  const SendFriendRequestDialog({ Key key, this.user }) : super(key: key);

  final UserModel user;

  @override
  State<SendFriendRequestDialog> createState() => _SendFriendRequestDialogState();
}

class _SendFriendRequestDialogState extends State<SendFriendRequestDialog> {

  String tempUsername;
  String tempUserNameId;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    Random random = Random();
    final size = MediaQuery.of(context).size;
    
    return Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: Container(
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //const SizedBox(height: 50,),
                Container(
                  //alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 15,
                  ),
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: size.width < size.height ? 0 : size.width * 0.17 ),
                  // decoration: BoxDecoration(
                  //   color: kThemeColor.withAlpha(60),
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // const Text(
                          //   "Enter the username: "
                          
                          // ),
                          Flexible(
                            child: LogFormField(
                              text: "username", 
                              onChanged: (value) => setState(() => tempUsername = value), 
                              isPw: false
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // const Text(
                          //   "Enter the ID: "
                          
                          // ),
                          SizedBox(
                            width: 70,
                            child: LogFormField(
                              text: "####", 
                              onChanged: (value) => setState(() => tempUserNameId = value), 
                              isPw: false,
                              inputType: const TextInputType.numberWithOptions(),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                _isLoading ? Container(
                  color: Colors.transparent,
                  height: 25,
                  child: Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: kMainColor,
                        //
                      ),
                    ),
                  ),
                ) 
                // LogBigButton( // set username
                //   text: "Send Friend Request",
                //   press: () async
                //   {
                //     Feedback.forTap(context);
                //     setState(() => _isLoading = true);
                //     var result = await Database(uid: widget.user.uid).sendFriendRequest(
                //       username: tempUsername,
                //       usernameId: int.parse(tempUserNameId),
                //     );
                    
                //     if (result == null)
                //     {
                //       setState(() => _isLoading = false);
                //     }
                //     else
                //     {
                //       setState(() => _isLoading = false);
                //       customSnackBar(
                //         context: context, 
                //         type: 1, 
                //         text: "Friend request sent!"
                //       );
                //     }
                //   },
                //   buttonColor: kMainColor,
                //   textColor: darkPrimaryTextColor,
                // ),
                :Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("CONFIRM", style: TextStyle(color: kMainColor),),
                        onPressed: () async
                      {
                        Feedback.forTap(context);

                        if(tempUserNameId.length == 4 && RegExp(r'^[0-9]+$').hasMatch(tempUserNameId)) // tempUserNameId has for digits only
                        {
                          setState(() => _isLoading = true);
                          var result = await Database(uid: widget.user.uid).sendFriendRequest(
                            context: context,
                            username: tempUsername,
                            usernameId: tempUserNameId,
                          );
                          Navigator.pop(context);
                          if (result == null)
                          {
                            setState(() => _isLoading = false);
                          }
                          else
                          {
                            setState(() => _isLoading = false);
                          }
                          //Navigator.pop(context);
                        }
                        else
                        {
                          customSnackBar(
                            context: context, 
                            type: -1, 
                            text: "Username ID must be 4 digits!"
                          );
                        }
                        
                      },
                    ),
                    const SizedBox(width: 9,),
                    TextButton(
                      child: Text("Cancel", style: TextStyle(color: kMainColor),),
                      onPressed:  () 
                      {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
  }
}