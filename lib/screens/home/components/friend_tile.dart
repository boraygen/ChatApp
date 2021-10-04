import 'dart:math';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/home/components/shared_values.dart';
import 'package:chat_app/screens/home/components/user_info_card.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/material.dart';

class FriendTile extends StatefulWidget {
  const FriendTile({
    Key key,
    this.friend, this.press, this.currentUser, this.isMini, this.index
  }) : super(key: key);

  final UserModel friend;
  final UserModel currentUser;
  final Function press;
  final bool isMini;
  final int index;

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  bool _isLoading = false;
  Random random = Random();
  bool _isTileSelected = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double rowWidth = widget.isMini ? size.width * 0.56 : size.width < size.height ? size.width * 0.75 : size.width * 0.81;
    double usernameWidth = widget.isMini ? size.width * 0.56 : size.width * 0.67;
    double statusWidth = widget.isMini ? size.width * 0.455 : size.width * 0.62;

    return _isLoading ? Container(
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
      :ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: _isTileSelected ? kSelectedTileColor : Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: widget.isMini ? () 
      {
        if(!Shared.createChatRoom_SelectedUserIndexes.contains(widget.index))
        {
          Shared.createChatRoom_SelectedUserIndexes.add(widget.index);
        }
        else
        {
          Shared.createChatRoom_SelectedUserIndexes.remove(widget.index);
        }
        setState(() => _isTileSelected = !_isTileSelected);
      } : (){},
      
      child: Container(
        color: Colors.transparent,
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
            ClipRRect(
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
              child: SizedBox(
                width: rowWidth,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container( // username
                                //color: Colors.red,
                                width: usernameWidth,
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
                            //IconButton(onPressed: () => _showUserInfoCard(context), icon: const Icon(Icons.more_horiz_outlined, size: 21,))
                            
                          ],
                        ),
                        Row(
                          children: [
                            Text( // #id
                              "#${widget.friend.usernameId}",
                              style: TextStyle(
                                color: kAccentTextColor2,
                              ),
                            ),
                            Container( // : status
                              //color: Colors.red,
                              width: statusWidth,
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
                    widget.isMini ? const SizedBox() : Positioned(
                      right: 12,
                      top: 13,
                      child: PopupMenuButton<Widget>(
                            // child: Text("click")
                            child: const Icon(Icons.more_horiz_outlined, size: 26,),
                            itemBuilder: (context) 
                              => [
                                PopupMenuItem( // Profile
                                  height: 47,
                                  child: CustomPopupMenuItemChild(
                                    text: "Profile",
                                    onTap: () 
                                    {
                                      Feedback.forTap(context);
                                      Navigator.pop(context);
                                      _showUserInfoCard(context);
                                    },
                                  ),
                                ),
                                PopupMenuItem(  // Message
                                  height: 47,
                                  child: CustomPopupMenuItemChild(
                                    text: "Message",
                                    onTap: () 
                                    {
                                      Feedback.forTap(context);
                                      Navigator.pop(context);
                                      // open/create chat room
                                    },
                                  ),
                                ),
                                // PopupMenuItem(
                                //   height: 47,
                                //   child: const Text("Add/Edit Note"),
                                //   onTap: () {},
                                // ),
                                PopupMenuItem(  // Unfriend
                                  height: 47,
                                  child: CustomPopupMenuItemChild(
                                    text: "Unfriend",
                                    onTap: () async
                                    {
                                      Feedback.forTap(context);
                                      Navigator.pop(context);
                                      await showAreYouSureDialog(
                                        context: context,
                                        title: widget.friend.username,
                                        question: "Are you sure you want to remove this user from your friend list?",
                                        optional: null,
                                        actionButtonText: "UNFRIEND",
                                        actionButtonOnPressed:  () async
                                        {
                                          setState(() => _isLoading = true);
                                          Navigator.pop(context);
                                          var result = await Database(uid: widget.currentUser.uid).removeFriend(context, widget.friend.uid);
      
                                          if (result == null)
                                          {
                                            setState(() => _isLoading = false);
                                          }
                                          else
                                          {
                                            setState(() => _isLoading = false);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                PopupMenuItem(  // Block
                                  height: 47,
                                  child: CustomPopupMenuItemChild(
                                    text: "Block",
                                    onTap: () async
                                    {
                                      Feedback.forTap(context);
                                      Navigator.pop(context);
                                      await showAreYouSureDialog(
                                        context: context,
                                        title: widget.friend.username,
                                        question: "Are you sure you want to block this user?",
                                        optional: null,
                                        actionButtonText: "BLOCK",
                                        actionButtonOnPressed:  () async
                                        {
                                          setState(() => _isLoading = true);
                                          Navigator.pop(context);
      
                                          var result = await Database(uid: widget.currentUser.uid).blockUser(widget.friend.uid);
      
                                          if (result == null)
                                          {
                                            setState(() => _isLoading = false);
                                          }
                                          else
                                          {
                                            customSnackBar(
                                              context: context, 
                                              type: 1, 
                                              text: "User has been blocked."
                                            );
                                            setState(() => _isLoading = false);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]
                          ),
                    ),
                  
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
}

class CustomPopupMenuItemChild extends StatelessWidget {
  const CustomPopupMenuItemChild({
    Key key,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 47,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text)
            )
          ),
        ),
        
      ),
    );
  }
}

