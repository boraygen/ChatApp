import 'package:chat_app/models/friend_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/home/components/blocked_tile.dart';
import 'package:chat_app/screens/home/components/friend_request_tile.dart';
import 'package:chat_app/screens/home/components/friend_tile.dart';
import 'package:chat_app/screens/home/components/mid_screen_info.dart';
import 'package:chat_app/screens/home/components/shared_values.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({ Key key, @required this.user,  }) : super(key: key);

  final UserModel user;
  

  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {

  // bool _showBlocked;
  // bool _showRequests;
  
  @override
  void initState() {
    super.initState();
    showBlocked = false;
    showRequests = false;
  }

  @override
  Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;

  return StreamBuilder<UserModel>(
      stream: Database(uid: widget.user.uid).currentUser,
      builder: (context,userSnapshot) {
        UserModel currentUser = userSnapshot.data;

        if (userSnapshot.hasData)
        {
          currentUser.friends.sort((FriendModel a, FriendModel b)=>a.username.toLowerCase().compareTo(b.username.toLowerCase()));
          return ListView.builder(
            itemCount: _getItemCount(showBlocked, showRequests, currentUser),
            itemBuilder: (context, index)
            {
              if(index == 0)
              {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(  // friend requests bar
                      style: ElevatedButton.styleFrom(
                        primary: showRequests ? kMainColor : kContainerColor,
                        shadowColor: kContainerColor,
                        elevation: 0,
                      ),
                      onPressed: currentUser.friendRequests.isEmpty ?
                      ()
                      {
                        if(showRequests)
                        {
                          setState(() => showRequests = false);
                        }
                        else
                        {
                          customSnackBar(
                            context: context,
                            type: 0,
                            text: "No friend request to show.",
                          );
                        }
                      }
                      : () => setState(() 
                      {
                        showBlocked ?showBlocked = false : null;
                        showRequests = !showRequests;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
                        height: 40,
                        width: size.width * 0.67,
                        child: Row(
                          children: [
                            const Text(
                              "Friend Requests: ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: currentUser.friendRequests.isEmpty ? 0 : 3,
                              ),
                              child: Text(
                                "${currentUser.friendRequests.length}",
                                style: currentUser.friendRequests.isEmpty ? const TextStyle(
                                  fontSize: 15,
                                ) :
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.5,
                                  color: showRequests ? kThemeColor : kMainColor,
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(  // blocked
                      style: ElevatedButton.styleFrom(
                        primary: showBlocked ? kMainColor : kContainerColor,
                        shadowColor: kContainerColor,
                        elevation: 0,
                      ),
                      onPressed: currentUser.blocked.isEmpty ? 
                      ()
                      {
                        if(showBlocked)
                        {
                          setState(() => showBlocked = false);
                        }
                        else
                        {
                          customSnackBar(
                            context: context,
                            type: 0,
                            text: "No blocked user found.",
                          );
                        }
                      }
                      :() => setState(() 
                      {
                        showRequests ? showRequests = false : null;
                        showBlocked = !showBlocked;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
                        height: 40,
                        width: size.width * 0.16,
                        child: Row(
                          children: [
                            Text(
                              "Blocked",
                              style: TextStyle(
                                color: showBlocked ? kSecondaryTextColor : kAccentTextColor2,
                                fontSize: 15,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              else {
                if (showBlocked) 
                {
                  return currentUser.blocked.isEmpty ?
                  MidScreenInfo(
                    size: size, 
                    text: "No blocked user found."
                  )
                  :StreamBuilder<UserModel>(
                    stream: Database(uid: currentUser.blocked[index - 1]).currentUser,
                    builder: (context, blockedSnapshot)
                    {
                      UserModel blockedUser = blockedSnapshot.data;
                      
                      if(blockedSnapshot.hasData)
                      {
                        return BlockedTile(
                          currentUser: currentUser,
                          blockedUser: blockedUser,
                          press: (){},
                        );
                      }
                      else
                      {
                        return Center(child: LogBigButtonLoading(color: kMainColor,));
                      }
                    }
                  );
                } 
                else if(showRequests)
                {
                  return currentUser.friendRequests.isEmpty ?
                  MidScreenInfo(
                    size: size, 
                    text: "No friend request to show."
                  )
                  :StreamBuilder<UserModel>(
                    stream: Database(uid: currentUser.friendRequests[index - 1]).currentUser,
                    builder: (context, friendSnapshot)
                    {
                      UserModel friendRequest = friendSnapshot.data;
                      
                      if(friendSnapshot.hasData)
                      {
                        return FriendRequestTile(
                          currentUser: currentUser,
                          friend: friendRequest,
                          press: (){},
                        );
                      }
                      else
                      {
                        return Center(child: LogBigButtonLoading(color: kMainColor,));
                      }
                    }
                  );
                }
                else 
                {
                  return currentUser.friends.isEmpty ? 
                  MidScreenInfo(size: size, text: "Add a friend to start chatting!"):
                  StreamBuilder<UserModel>(
                    stream: Database(uid: currentUser.friends[index - 1].uid).currentUser,
                    builder: (context, friendSnapshot)
                    {
                      UserModel friend = friendSnapshot.data;
                      
                      if(friendSnapshot.hasData)
                      {
                        return FriendTile(
                          currentUser: currentUser,
                          friend: friend,
                          isMini: false,
                          press: (){},
                        );
                      }
                      else
                      {
                        return Center(child: LogBigButtonLoading(color: kMainColor,));
                      }
                    }
                  );
                }
              }
            },
          );
        }
        
        else
        {
          return Center(child: LogBigButtonLoading(color: kMainColor,));
        }
      }
    );
  }
}



int _getItemCount(bool showBlocked, bool showRequests, UserModel currentUser)
{
  if(showBlocked)
  {
    return (currentUser.blocked.isEmpty ? 2 : currentUser.blocked.length + 1);
  }
  if(showRequests)
  {
    return (currentUser.friendRequests.isEmpty ? 2 : currentUser.friendRequests.length + 1);
  }
  else
  {
    return (currentUser.friends.isEmpty ? 2 : currentUser.friends.length + 1);
  }
}
            