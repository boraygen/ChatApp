import 'dart:math';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/home/components/user_info_card.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedTile extends StatefulWidget {
  const BlockedTile({
    Key key,
    @required this.blockedUser, @required this.currentUser, this.press
  }) : super(key: key);

  final UserModel blockedUser;
  final UserModel currentUser;
  final Function press;

  @override
  State<BlockedTile> createState() => _BlockedTileState();
}

class _BlockedTileState extends State<BlockedTile> {

  bool _isLoading = false;
  Random random = Random();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  _isLoading ? Container(
        color: Colors.transparent,
        height: 61,
        child: Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: kAccentColor,
              //
            ),
          ),
        ),
      )
      : ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: ()
      {
        _showUserInfoCard(context);
      },
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(
          //horizontal: kDefaultPadding * 0.1,
          vertical: 5,   
        ),
        width: size.width,
        height: 61,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const Icon(Icons.account_circle_rounded, size: 50,),
            ClipRRect(  // image
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                "assets/dummyLogos/dummyChatLogo" "${random.nextInt(8)}" ".png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                //color: Colors.teal,
                width: size.width < size.height ? size.width * 0.75 : size.width * 0.87,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align( // username
                          alignment: Alignment.centerLeft,
                          child: Container( 
                            //color: Colors.red,
                            width:  size.height > size.width ? size.width * 0.445 : size.width * 0.604,
                            child: Text(
                              widget.blockedUser.username,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        Row(  // id : status
                          children: [
                            Text( // #id
                              "#${widget.blockedUser.usernameId}",
                              style: TextStyle(
                                color: kAccentTextColor2,
                              ),
                            ),
                            Container( // : status
                            //color: Colors.red,
                              width: size.height > size.width ? size.width * 0.34 : size.width * 0.55,
                              child: Text(
                                " : \"${widget.blockedUser.status}\"",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kAccentTextColor1
                                ),  
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.07,),
                    SizedBox(
                      height: 26,
                      child: ElevatedButton( // unblock button
                        style: ElevatedButton.styleFrom(
                          primary: kAccentTextColor1,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () async
                        {
                          //await _showSureToUnblock(context, widget.blockedUser.username);
                          await showAreYouSureDialog(
                            context: context,
                            title: widget.blockedUser.username,
                            question: "Are you sure you want to unblock this user?",
                            optional: const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "This won't make you friends automatically!",
                                    style: TextStyle(
                                      fontSize: 13.5
                                    ),
                                  ),
                                ),
                              ),
                            actionButtonText: "UNBLOCK",
                            actionButtonOnPressed:  () async
                            {
                              setState(() => _isLoading = true);
                              Navigator.pop(context);
                              var result = await Database(uid: widget.currentUser.uid).unblockUser(widget.blockedUser.uid);

                              if (result == null)
                              {
                                setState(() => _isLoading = false);
                              }
                              else
                              {
                                customSnackBar(
                                  context: context, 
                                  type: 1, 
                                  text: "User is now unblocked."
                                );
                                setState(() => _isLoading = false);
                              }
                            },
                             
                          );
                        },
                        child: Text(
                          "Unblock",
                          style: TextStyle(
                            color: kSecondaryTextColor,
                            fontSize: 12.5
                          ),
                        )
                      ),
                    ),
                    //const SizedBox(width: 24,),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showUserInfoCard(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(
            top: 16,
            left: 20,
            right: 20,
            bottom: 1
          ),
          elevation: 4,
          title: null,
          content: UserInfoCard(user: widget.blockedUser),
          // actions: [
          //   closeButton,  
          // ],
        );
      },
    );
  }

  
}
