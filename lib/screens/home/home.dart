import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/authentication/components/logout_icon_button.dart';
import 'package:chat_app/screens/home/components/send_friend_request_dialog.dart';
import 'package:chat_app/screens/home/components/shared_values.dart';
import 'package:chat_app/screens/home/tabs/chats_tab/chats_tab.dart';
import 'package:chat_app/screens/home/tabs/chats_tab/subscreens/create_chat_room.dart';
import 'package:chat_app/screens/home/tabs/friends_tab/friends_tab.dart';
import 'package:chat_app/screens/home/components/search.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  const Home({ Key key, @required this.user}) : super(key: key);

  final UserModel user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  final Auth auth = Auth();
  TabController _tabController;
  //bool redraw = false;

  @override
  void initState()
  {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return StreamBuilder<UserModel>(
      stream: Database(uid: widget.user.uid).currentUser,

      builder: (context,snapshot) {
        UserModel currentUser = snapshot.data;

        if (snapshot.hasData)
        {
          
          return Scaffold(
            appBar: defaultAppBar(
              actions: 
              [
                Padding(  // username#id
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          widget.user.username ?? currentUser.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        Text(
                          "#" "${widget.user.usernameId  ?? currentUser.usernameId}"),
                      ],
                    ),
                  ),
                ),
                Padding( // logout
                  padding: const EdgeInsets.only(top: 2.0),
                  child: LogoutIconButton(),
                ),
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelPadding: const EdgeInsets.only(bottom: 10,),
                controller: _tabController,
                onTap: (page)
                {
                  if(page == 1)
                  {
                    if(showRequests || showBlocked)
                    {
                      setState(() 
                      {
                        showRequests = false;
                        showBlocked = false;
                      });
                    }
                  }
                },
                tabs: const [
                  Text("Chats"),
                  Text("Friends"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                const ChatsTab(),
                FriendsTab(
                  user: currentUser,
                  
                ),
                // FriendRequests(
                //   user: widget.user,
                // ),
              ],
            ),
            
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  const SizedBox(height: 25,),
                  FloatingActionButton( // add chat room OR add friend
                    heroTag: "add",
                    backgroundColor: kMainColor,
                    elevation: 0,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:  () => _tabController.index == 0 ? Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) =>  CreateChatRoom(
                          user: currentUser
                        ) 
                      ) 
                    ) : _showAddFriendDialog(context, currentUser),
                  ),
                  const SizedBox(height: 15,),
                  FloatingActionButton( // search
                    heroTag: "search",
                    backgroundColor: kMainColor,
                    elevation: 0,
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const Search()
                      )
                    ),
                  ),
                  const SizedBox(height: 5,),

                ],
              ),
            )
          );
        }
        else{
          return Scaffold(
            appBar: defaultAppBar(
              actions: null,
              bottom: null,
            ),
            body: Center(child: LogBigButtonLoading(color: kMainColor,)),
          );
        }
        
      }
    );
  }
  _showAddFriendDialog(BuildContext context, UserModel user) {
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
          title: const Text(
            "Add a friend",
          ),
          content: SendFriendRequestDialog(user: user),
          //content: UserInfoCard(user: user,),
          // actions: [
          //   closeButton,  
          // ],
        );
      },
    );
  }
}
