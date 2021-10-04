import 'dart:math';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/home/components/user_info_card.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendRequestTile extends StatefulWidget {
  const FriendRequestTile({
    Key key,
    this.friend, this.currentUser, this.press
  }) : super(key: key);

  final UserModel friend;
  final UserModel currentUser;
  final Function press;

  @override
  State<FriendRequestTile> createState() => _FriendRequestTileState();
}

class _FriendRequestTileState extends State<FriendRequestTile> {

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
                              widget.friend.username,
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
                              "#${widget.friend.usernameId}",
                              style: TextStyle(
                                color: kAccentTextColor2,
                              ),
                            ),
                            Container( // : status
                            //color: Colors.red,
                              width: size.height > size.width ? size.width * 0.34 : size.width * 0.55,
                              child: Text(
                                " : \"${widget.friend.status}\"",
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
                    ElevatedButton( // accept
                      style: ElevatedButton.styleFrom(
                        primary: kAccentColor,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () async
                      {
                        setState(() => _isLoading = true);
                        var result = await Database(uid: widget.currentUser.uid).acceptFriendRequest(widget.friend.uid);

                        if (result == null)
                        {
                          setState(() => _isLoading = false);
                        }
                        else
                        {
                          setState(() => _isLoading = false);
                          customSnackBar(
                            context: context, 
                            type: 1, 
                            text: "You are now friends!"
                          );
                        }
                      },
                      child: const Text(
                        "Accept",
                        style: TextStyle(
                          fontSize: 12
                        ),
                      )
                    ),
                    const SizedBox(width: 24,),
                    GestureDetector(  // reject
                      onTap: () async
                      {
                        Feedback.forTap(context);
                        //setState(() => _isLoading = true);
                        await _showSureToRejectRequest(context, widget.friend.username);
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kAppBarColor,
                          borderRadius: BorderRadius.circular(18)
                        ),
                        height: 25,
                        width: 25,
                        child: const Icon(Icons.close_rounded, size: 16,),
                      ),
                    )
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
          content: UserInfoCard(user: widget.friend),
          // actions: [
          //   closeButton,  
          // ],
        );
      },
    );
  }

  _showSureToRejectRequest(BuildContext context, String friendName)
  {
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
          titleTextStyle: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16.5,
            fontWeight: FontWeight.bold,
          ),
          title: Text(
            "$friendName" ,
          ),
          content: const Text(
            "Are you sure you want to reject this friend request?",
            style: TextStyle(
              fontSize: 15
            ),
          ),
          actions: [
            TextButton(
              child: Text("REJECT", style: TextStyle(color: kMainColor),),
              onPressed:  () async
              {
                setState(() => _isLoading = true);

                var result = await Database(uid: widget.currentUser.uid).rejectFriendRequest(widget.friend.uid);
                //var result = await Database(uid: widget.currentUser.uid).test();
                Navigator.pop(context);


                if (result == null)
                {
                  setState(() => _isLoading = false);
                }
                else
                {
                  setState(() => _isLoading = false);
                }
                
              },
            ),
            TextButton(
              child: Text("Cancel", style: TextStyle(color: kMainColor),),
              onPressed:  () 
              {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
