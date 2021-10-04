import 'package:chat_app/models/friend_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/log_big_button.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/authentication/components/log_subtitle.dart';
import 'package:chat_app/screens/home/components/friend_tile.dart';
import 'package:chat_app/screens/home/components/shared_values.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class CreateChatRoom extends StatefulWidget {
  const CreateChatRoom({ Key key, this.user }) : super(key: key);

  final UserModel user;

  @override
  _CreateChatRoomState createState() => _CreateChatRoomState();
}

class _CreateChatRoomState extends State<CreateChatRoom> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    widget.user.friends.sort((FriendModel a, FriendModel b)=>a.username.toLowerCase().compareTo(b.username.toLowerCase()));


    return Scaffold(
      appBar: defaultAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.076
          ),
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              const LogSubtitle(
                subtitle: "Select one or multiple friends\nto start chatting:",
              ),
              const SizedBox(height: 15,),
              Container(  // search bar
                alignment: Alignment.center,
                // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,
                // vertical: kDefaultPadding * 0.5),
                height: 45,
                margin: EdgeInsets.only(right: size.width < size.height ? 0 : size.width * 0.1 ),
                decoration: BoxDecoration(
                  color: kThemeColor.withAlpha(60),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: size.width * 0.7,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 8, top: 5),
                      hintText: "Search ",
                      suffixIcon: const Icon(Icons.search_rounded, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kMainColor),
                      ),
                    ),
                    onChanged: (value) => setState(() => _searchText = value),                
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,
                // vertical: kDefaultPadding * 0.5),
                height: size.height * 0.6,
                margin: EdgeInsets.only(right: size.width < size.height ? 0 : size.width * 0.1 ),
                decoration: BoxDecoration(
                  color: kThemeColor.withAlpha(60),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: widget.user.friends.length,
                  itemBuilder: (context, index)
                  {
                    return StreamBuilder(
                      stream: Database(uid: widget.user.friends[index].uid).currentUser,
                      builder: (context, friendSnapshot) 
                      {
                        UserModel friend = friendSnapshot.data;

                        if(friendSnapshot.hasData)
                        {
                          return FriendTile(
                            currentUser: widget.user,
                            friend: friend,
                            isMini: true,
                            index: index,
                          );
                        }
                        else
                        {
                          return Center(child: LogBigButtonLoading(color: kMainColor,));
                        }
                      }
                    );
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 18,
                  right: size.width < size.height ? 0 : size.width * 0.1, 
                ),
                child: LogBigButton(
                  buttonColor: kMainColor,
                  textColor: kPrimaryTextColor,
                  text: "Create Room",
                  press: ()
                  {
                    //Database(uid: ).createChatRoom();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}